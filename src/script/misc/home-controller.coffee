angular.module("laere").controller "HomeController", ($scope, Global, Schools) ->
  $scope.global = Global
  $scope.schools = Schools.query()