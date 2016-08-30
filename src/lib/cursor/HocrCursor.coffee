Token      = require '../Token'
TokenTypes = require '../TokenTypes'
Cursor = require '../Cursor'

Cheerio = require 'cheerio'

module.exports = \

##
# Cursor for navigating hocr files
class HocrCursor extends Cursor

	@supportedTokens: [
		'char'
		'bword'
		'line'
	]

	constructor: (opts={}) ->
		unless opts.text
			throw new Error("Should pass text")
		@$ = Cheerio.load(opts.text, withDomLvl1: true)

	cur: (tobjType) ->
