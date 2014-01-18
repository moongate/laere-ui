window.laere or= {baseUrl:''}

window.app = angular.module("laere", ["ngResource", "ngRoute", "pascalprecht.translate",
                                      "ui.bootstrap", "ngAnimate",
                                      "laere.schools", "laere.users", "laere.courses", "laere.classrooms", "laere.progress"])
angular.module "laere.schools", []
angular.module "laere.users", []
angular.module "laere.courses", []
angular.module "laere.classrooms", []
angular.module "laere.progress", []

app.factory "Global", [=>
  @_data =
    user: window.laere.user
    authenticated: !!window.laere.user
    school: window.laere.school
    env: window.laere.env
    host: window.laere.host

  @_data
]

#Setting up route
app.config ($routeProvider) ->
  $routeProvider
  .when "/schools",
    templateUrl: "views/schools/list.html"
  .when "/schools/create",
    templateUrl: "views/schools/edit.html"
  .when "/schools/:schoolId/edit",
    templateUrl: "views/schools/edit.html"
  .when "/schools/:schoolId",
    templateUrl: "views/schools/view.html"
  .when "/users",
    templateUrl: "views/users/list.html"
  .when "/users/create",
    templateUrl: "views/users/edit.html"
  .when "/users/:userId/edit",
    templateUrl: "views/users/edit.html"
  .when "/users/:userId",
    templateUrl: "views/users/view.html"
  .when "/classrooms",
    templateUrl: "views/progress/list.html"
  .when "/progress/:progressId",
    templateUrl: "views/progress/view.html"
  .when "/teach/:classroomId",
    templateUrl: "views/teach/view.html"
  .when "/teach/:classroomId/progress/:progressId",
    templateUrl: "views/teach/view.html"
  .when "/courses",
    templateUrl: "views/courses/list.html"
  .when "/courses/create",
    templateUrl: "views/courses/edit.html"
  .when "/courses/:courseId/edit",
    templateUrl: "views/courses/edit.html"
  .when "/courses/:courseId",
    templateUrl: "views/courses/view.html"
  .when "/login",
    templateUrl: "views/auth/login.html"
  .when "/signup",
      templateUrl: "views/auth/signup.html"
  .when "/",
    templateUrl: "views/home.html"
  .otherwise redirectTo: "/"

app.config ($translateProvider) ->
  $translateProvider.useStaticFilesLoader
    prefix: window.laere.baseUrl + 'i18n/'
    suffix: '.json'
  $translateProvider.preferredLanguage 'pt-BR'

app.run ($rootScope) ->
  $rootScope.school = window.laere.school
  $rootScope.messages =
    error: window.laere.error
    warning: window.laere.warning
    success: window.laere.success


angular.element(document).ready ->
  window.location.hash = ""  if window.location.hash is "#_=_" # Fixing facebook bug with redirect
  angular.bootstrap document, ["laere"] # Initialize the app
