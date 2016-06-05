MkdirP  = require 'mkdirp'
Fs      = require 'fs'
Path    = require 'path'
Utils = require './Utils'
Async = require 'async'

module.exports =\

##
# Cache data for URIs
class UriCache

	constructor: (@cacheDir) ->

	##
	# Create `cacheDir` unless it exists
	initialize : (cb) ->
		MkdirP @cacheDir, cb

	##
	# Store data in the cache
	#
	# @param {String} uri
	# @param {String} data
	# @param {Function} cb
	put : (uri, data, cb) ->
		Fs.writeFile Path.join(@cacheDir, Utils.uriToFilename(uri)), data, cb

	##
	# Retrieve data for a URI
	#
	# @param {String} uri
	# @param {Function} cb
	get : (uri, cb) ->
		fname = Path.join(@cacheDir, Utils.uriToFilename(uri))
		Fs.readFile fname, {encoding: 'utf-8'}, (err, data) ->
			return cb err if err
			return cb null, data

	##
	# Clear the whole cache
	#
	# @param {Function} cb
	clear : (cb)->
		Fs.readdir @cacheDir, (err, relFiles) =>
			Async.each relFiles, (relFile, done) =>
				Fs.unlink Path.join(@cacheDir, relFile), done
			, cb

