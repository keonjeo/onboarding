var myApp = angular.module('myapplication', ['ngRoute', 'ngResource']);

//Use the Factory to define the Users Service
myApp.factory('Users', ['$resource',function($resource){
    return $resource('/users.json', {},{
        query: { method: 'GET', isArray: true },
        create: { method: 'POST' }
    })
}]);

//Use the Factory to define the User Service
myApp.factory('User', ['$resource', function($resource){
    return $resource('/users/:id.json', {}, {
        show: { method: 'GET' },
        update: { method: 'PUT', params: {id: '@id'} },
        delete: { method: 'DELETE', params: {id: '@id'} }
    });
}]);

//Use the Factory to define the userService to fetch the data related to the user
myApp.factory('userService', ['$http', function ($http) {
    return {
        getUser: function(userId) {
            return $http.get('/users/' + userId + '.json');
        }
    }
}]);

//Controller
myApp.controller("UserListCtr", ['$scope', '$resource', 'Users', 'User', '$location', function($scope, $resource, Users, User, $location) {
    $scope.users = Users.query();
    $scope.deleteUser = function (userId) {
        if (confirm("Are you sure you want to delete this user?")){
            User.delete({ id: userId }, function(){
                $scope.users = Users.query();
                $location.path('/');
            });
        }
    };
}]);

myApp.controller("UserUpdateCtr", ['$scope', '$resource', 'User', '$location', '$routeParams', function($scope, $resource, User, $location, $routeParams) {
    $scope.user = User.get({id: $routeParams.id});
    $scope.update = function(){
        if ($scope.userForm.$valid){
            User.update({id: $scope.user.id.$oid},{user: $scope.user},function(){
                $location.path('/users/' + $scope.user.id.$oid + '/show');
            }, function(error) {
                console.log(error)
            });
        }
    };
}]);

myApp.controller("UserAddCtr", ['$scope', '$resource', 'Users', '$location', function($scope, $resource, Users, $location) {
    $scope.user = {}
    $scope.save = function () {
        if ($scope.userForm.$valid){
            Users.create({user: $scope.user}, function(){
                $location.path('/');
            }, function(error){
                console.log(error)
            });
        }
    };
}]);

// myApp.controller("UserShowCtr", ['$scope', '$routeParams', 'User', function($scope, $routeParams, User) {
//     $scope.user = User.get({id: $routeParams.id});
// }]);

myApp.controller("UserShowCtr", ['$scope', '$routeParams', 'userService', function($scope, $routeParams, userService) {
    var promise = userService.getUser($routeParams.id);
    promise.then(
        function(payload) {
            $scope.user = payload.data;
        },
        function(errorPayload) {
            console.log('failure loading user', errorPayload);
        }
    );
}]);

// Define the Directives
myApp.directive('userForm', function() {
    return {
        templateUrl: '/templates/users/_form.html'
    }
})


//Routes
myApp.config([
    '$routeProvider', function($routeProvider) {
        $routeProvider.when("/users",{
            templateUrl: "/templates/users/index.html",
            controller: "UserListCtr"
        });
        $routeProvider.when("/users/new", {
            templateUrl: "/templates/users/new.html",
            controller: "UserAddCtr"
        });
        $routeProvider.when("/users/:id/edit", {
            templateUrl: "/templates/users/edit.html",
            controller: "UserUpdateCtr"
        });
        $routeProvider.when("/users/:id/show", {
            templateUrl: "/templates/users/show.html",
            controller: "UserShowCtr"
        });
        $routeProvider.otherwise({
            redirectTo: "/users"
        });
    }
]);