angular.module("laere").controller "HeaderController", ($scope, Global) ->
  $scope.global = Global
  $scope.menu = [
    title: "header.schools"
    link: "schools"
  ,
    title: "header.users"
    link: "users"
  ,
    title: "header.classrooms"
    link: "classrooms"
  ,
    title: "header.courses"
    link: "courses"
  ,
    title: "header.contents"
    link: "contents"
  ]