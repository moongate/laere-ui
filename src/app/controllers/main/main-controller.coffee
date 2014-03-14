angular.module("laere").controller "MainController", ($rootScope, $scope, Global) ->
  $scope.global = Global

  $rootScope.school = window.laere.school
  $rootScope.messages =
    error: window.laere.error
    warning: window.laere.warning
    success: window.laere.success