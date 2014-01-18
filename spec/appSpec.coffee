
describe 'Laere Module', ->

  # load the controller's module
  beforeEach module 'laere'

  HeaderController = scope = null

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    HeaderController = $controller 'HeaderController',
      $scope: scope

  it 'should have a defined menu', ->
    console.log scope
    expect(scope.global).toBeDefined()
