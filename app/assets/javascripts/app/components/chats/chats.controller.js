'use strict';

class chatsController {
  constructor(chats, $scope, FayeClient, users, $notification) {
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
        if (payload.name != $scope.currentUserName && payload.name != 'Error') {
          $notification(payload.name, {
            body: payload.message,
            tag: payload.name
          });
        }
        controllerThis.allMessages.push({name: payload.name,
                                         message: payload.message,
                                         time: payload.time});
      })

    });
    
    FayeClient.subscribe('/user_chats', function(payload) {
      $scope.$apply(()=>{
        if (payload.name != $scope.currentUserName) {
          $notification(payload.name, {
            body: payload.message,
            tag: payload.name
          });
        }
        controllerThis.allMessages.push({name: payload.name,
                                         message: payload.message,
                                         time: payload.time});
      })

    });

    this.addressee = (author)=>{
      author = author.split(' ');
      this.message = '@' + author[0] + ':';
    }

  }

}

chatsController.$inject = ['chats', '$scope', 'FayeClient', 'users', '$notification'];

angular.module('ngSpaApp')
  .controller('chatsController', chatsController);
