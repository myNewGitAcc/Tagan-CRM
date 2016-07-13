'use strict';

class chatsController {
  constructor(chats, $scope, FayeClient, users) {
    this.message = "";
    this.allMessages = [];
    var controllerThis = this;
    users.getUsers().then((response)=>{
      this.users = response.data.data;
    });

    this.sendMessage = ()=>{
      var time = moment(new Date()).format('HH:mm:ss');
      chats.send($scope.currentUserName, this.message, time, this.users, $scope.currentUserId);
      this.message = '';
    };

    FayeClient.subscribe('/private_chats/'+$scope.currentUserId, function(payload) {
      $scope.$apply(()=>{
        controllerThis.allMessages.push({name: payload.name,
                                         message: payload.message,
                                         time: payload.time});
      })

    });
    
    FayeClient.subscribe('/user_chats', function(payload) {
      $scope.$apply(()=>{
        controllerThis.allMessages.push({name: payload.name,
                                         message: payload.message,
                                         time: payload.time});
      })

    });


  }

}

chatsController.$inject = ['chats', '$scope', 'FayeClient', 'users'];

angular.module('ngSpaApp')
  .controller('chatsController', chatsController);
