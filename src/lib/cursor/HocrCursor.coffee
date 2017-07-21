Token      = require '../Token'
TokenTypes = require '../TokenTypes'
Cursor = require '../Cursor'
Xml2Js = require('xml2js')
{DOMParser} = require('xmldom')
Xpath = require 'xpath'

module.exports = \

##
# Cursor for navigating hocr files
class HocrCursor extends Cursor

	# constructor: (opts={}) ->
	#   unless opts.text
	#     throw new Error("Should pass text")
	#   Xml2Js.parseString opts.text, (err, result) =>
	#     throw err if err
	#     @doc = result
	constructor: (opts={}) ->
		unless opts.text
			throw new Error("Must pass 'text'")
		@doc = new DOMParser().parseFromString(opts.text)
		@_calculate_positions()

	cur: (tokenType) ->
		@positions[tokenType][@offsets[tokenType]] or null

	_calculate_positions : ->
		@positions = {}
		for tokenType, re of TokenTypes
			@positions[tokenType] or= 0
			while (group = re.exec(@text)) != null
				@positions[tokenType].push new Token(tokenType, group.index, group[0])
		@_calculate_offsets()
		return @
