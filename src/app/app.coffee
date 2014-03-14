console.time 'laere'

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
    host: window.location.host.replace('www.', '')

  @_data
]

#Setting up route
app.config ($routeProvider) ->
  $routeProvider
  .when "/schools",
    templateUrl: "app/controllers/school/school-list.html"
  .when "/schools/create",
    templateUrl: "app/controllers/school/school-edit.html"
  .when "/schools/:schoolId/edit",
    templateUrl: "app/controllers/school/school-edit.html"
  .when "/schools/:schoolId",
    templateUrl: "app/controllers/school/school-view.html"
  .when "/users",
    templateUrl: "app/controllers/user/user-list.html"
  .when "/users/create",
    templateUrl: "app/controllers/user/user-edit.html"
  .when "/users/:userId/edit",
    templateUrl: "app/controllers/user/user-edit.html"
  .when "/users/:userId",
    templateUrl: "app/controllers/user/user-view.html"
  .when "/classrooms",
    templateUrl: "app/controllers/progress/progress-list.html"
  .when "/progress/:progressId",
    templateUrl: "app/controllers/progress/progress-view.html"
  .when "/teach/:classroomId",
    templateUrl: "app/controllers/teach/teach-view.html"
  .when "/teach/:classroomId/progress/:progressId",
    templateUrl: "app/controllers/teach/teach-view.html"
  .when "/courses",
    templateUrl: "app/controllers/course/course-list.html"
  .when "/courses/create",
    templateUrl: "app/controllers/course/course-edit.html"
  .when "/courses/:courseId/edit",
    templateUrl: "app/controllers/course/course-edit.html"
  .when "/courses/:courseId",
    templateUrl: "app/controllers/course/course-view.html"
  .when "/login",
    templateUrl: "app/controllers/main/auth/login.html"
  .when "/signup",
      templateUrl: "app/controllers/main/auth/signup.html"
  .when "/",
    templateUrl: "app/controllers/home/home.html"
  .otherwise redirectTo: "/"

app.config ($translateProvider) ->
  $translateProvider.useStaticFilesLoader
    prefix: window.laere.baseUrl + 'assets/i18n/'
    suffix: '.json'
  $translateProvider.preferredLanguage 'pt-BR'

app.run  ->
  console.timeEnd 'laere'