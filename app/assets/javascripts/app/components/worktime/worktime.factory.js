'use strict';

(function() {

  function worktimeFactoryService($http, $rootScope, $interval) {

  	function repairDate(datePart){
  		return +datePart>=10?datePart:"0"+datePart;
  	}

  	function dateConstruct(mode) {//mode: 'short'='YYYY-MM-DD' or 'long'='YYYY-MM-DD HH:MM:SS'
  		var data = new Date();
  		var dataToDb =  data.getUTCFullYear() + 
  										"-" + 
  										repairDate(+data.getUTCMonth()+1) + 
  										"-" + 
  										repairDate(data.getUTCDate());
  		if(mode=='long')
  			dataToDb += " " +
  									repairDate(data.getUTCHours()) +
  									":" +
  									repairDate(data.getUTCMinutes()) +
  									":" +
  									repairDate(data.getUTCSeconds());
  		return dataToDb;

  	}

  	function request(method, id, params){
  		return $http({
  			method: method,
  			url: method=="PUT"?'/api/v1/working_times/'+id:'/api/v1/working_times',
  			params: params
  		})
  	}

    return {
      desintegration: (ms)=>{
        var dt = new Date(ms);
        var h = dt.getUTCHours();
        var m = dt.getUTCMinutes();
        var s = dt.getUTCSeconds();
        return  (h>0?h+(h==1?" час ":h<5?" часа ":" часов "):"") + 
                (m>0?m+(m==1?" минута ":m<5?" минуты ":m<21?" минут ":m%10==0?" минут ":m%10==1?" минута ":m%10<5?" минуты ":" минут "):"") + 
                (s>0?s+(s==1?" секунда":s<5?" секунды":s<21?" секунд":s%10==0?" секунд":s%10==1?" секунда":s%10<5?" секунды":" секунд"):"");
      },

      msRounding: (ms)=>{
      	return 1000*Math.floor(ms/1000);
      },

      runCalculation: (f, param1, param2)=>{
      	$rootScope.intervalId = $interval(f, 1000, 0, true, param1, param2);
      },

    	stopCalculation: () => {
    		if($rootScope.intervalId)
      		$interval.cancel($rootScope.intervalId);
  		},
  		
  		checkRecord: (id) => {
    		return request('GET', id, {user_id: id, created_at: dateConstruct('short')});
  		},

  		createRecord: (id) => {
    		return request('POST', id, {user_id: id, status_change_date: dateConstruct('long'), labor_hours: 0});
  		},

  		updateRecordAtStartOrResume: (id) => {
  			return request('PUT', id, {created_at: dateConstruct('short'), status_change_date: dateConstruct('long')});
  		},

  		updateRecordAtPauseOrAway: (id, time) => {
  			return request('PUT', id, {created_at: dateConstruct('short'), labor_hours: time});
  		}
    };
  }

  worktimeFactoryService.$inject = ['$http', '$rootScope', '$interval'];

  angular.module('ngSpaApp')
    .factory('worktimeFactory', worktimeFactoryService);
})();
