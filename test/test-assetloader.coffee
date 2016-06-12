AssetLoader = require '../src/AssetLoader'
Test = require 'tape'

loader = new AssetLoader()

Test 'initialize', (t) ->
	loader.initialize (err) ->
		t.notOk err, "No error initializing"
		t.end()

csvUri = 'https://www-test.bib.uni-mannheim.de/infolis/ocrrect/data/letter-to-number.csv'

Test csvUri, (t) ->
	loader.cache.clear (err) ->
		t.notOk err, 'Cleared cache'
		loader.load csvUri, datatype:'csv', (err, csv) ->
			t.notOk err, 'loading worked'
			t.ok csv, 'CSV loaded'
			console.log csv
			t.end()
