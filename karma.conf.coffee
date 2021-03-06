module.exports = (config) ->
	config.set
		files: [
      'spec/libs/angular/1.2.7/angular.min.js'
			'spec/libs/angular/1.2.7/angular-mocks.js'
			'spec/libs/angular/1.2.7/angular-animate.js'
			'spec/libs/angular/1.2.7/angular-route.min.js'
			'spec/libs/angular/1.2.7/angular-resource.min.js'
			'spec/libs/angular-translate/1.1.1/angular-translate.min.js'
			'spec/libs/angular-translate/1.1.1/angular-translate-loader-static-files/angular-translate-loader-static-files.min.js'
			'spec/libs/angular-bootstrap/0.9.0/ui-bootstrap-tpls.min.js'
			'spec/libs/moment/2.4.0/moment.min.js'
			'spec/libs/underscore/1.5.2/underscore-min.js'
			'src/app/**/*.coffee'
      {pattern:'src/assets/i18n/**/*.json', included:false}
			'spec/**/*.coffee'
		]
		frameworks: ['jasmine']
		browsers: ['PhantomJS']
		preprocessors:
			'**/*.coffee': 'coffee'
