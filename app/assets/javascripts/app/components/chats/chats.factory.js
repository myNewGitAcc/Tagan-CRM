'use strict';

(function() {

  function chatsService($http, FayeClient) {

    return {

      send: (full_name, message, time, allUsers, currentUserId) => {
        if ((message[0] == '@') && (~message.indexOf(':'))) {
          var nameUser = message.substring(1).split(':');
          nameUser[0] = nameUser[0].replace(/\n/g,'').replace(' ','');
          var user = searchName(nameUser[0], allUsers);
          if (user.length != 0){
            FayeClient.publish('/private_chats/'+user[0].id, {name: full_name, message: message, time: time});
            FayeClient.publish('/private_chats/'+currentUserId, {name: full_name, message: message, time: time});
          }
        } else {
          FayeClient.publish('/user_chats', {name: full_name, message: message, time: time});
        }

        return ;
      }
    };


    function searchName(nameUser, users) {
      var getUser = _.filter(users,
        function (user) {

          return searchUser(user, nameUser);
        });
      return getUser;
    }

    function searchUser(item, toSearch) {
      return (item.full_name.toLowerCase().indexOf(toSearch.toLowerCase()) == 0)  ? true : false;
    }

  }
  chatsService.$inject = ['$http', 'FayeClient'];

  angular.module('ngSpaApp')
    .factory('chats', chatsService);
})();
