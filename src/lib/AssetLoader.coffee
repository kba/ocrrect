Request = require 'superagent'
CsvParse = require 'csv-parse'
UriCache = require './UriCache'
{TRAF} = require 'traf'

module.exports =\

##
# Load CSV/JSON data from the web or from cache.
class AssetLoader

	constructor: (@config) ->
		@config or= {}
		@cache = new UriCache(@config.cacheDir or '/tmp/ocrrect.cache')

	initialize : (cb) ->
		@cache.initialize cb

	_parseData : (data, dataType, cb) ->
		if dataType.match /json/
			try
				res = JSON.parse data
			catch err
				return cb err
			return cb null, res
		else if dataType.match /csv/
			CsvParse data, cb
		else
			cb new Error("Unknown dataType #{dataType}")


	##
	# Load data from uri
	#
	# @param {String} uri
	# @param {Object} opts
	# @param {String} opts.datatype Data Type of the asset, 'csv' or 'json'
	# @param {Function} cb
	load : (uri, opts, cb) ->
		return cb new Error("Must specify dataType") if not opts.dataType
		@cache.get uri, (err, data) =>
			return @_parseData data, opts.dataType, cb unless err
			Request.get(uri).end (err, res) =>
				return cb err if err
				@cache.put uri, res.text, (err) =>
					return @_parseData res.text, opts.dataType, cb unless err
					cb err

