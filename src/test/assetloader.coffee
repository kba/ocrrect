AssetLoader = require '../lib/AssetLoader'
Test = require 'tape'
RootPath = require 'app-root-path'

loader = new AssetLoader()

Test 'initialize', (t) ->
	loader.initialize (err) ->
		t.notOk err, "No error initializing"
		t.end()

		# XXX todo
# csvUri = "file://#{__dirname}/../../data/letter-to-number.tsv"

# Test csvUri, (t) ->
#   loader.cache.clear (err) ->
#     t.notOk err, 'Cleared cache'
#     loader.load csvUri, dataType:'tsv', (err, csv) ->
#       t.notOk err, 'loading worked'
#       t.ok csv, 'CSV loaded'
#       console.log csv
#       t.end()
