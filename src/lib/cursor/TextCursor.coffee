Token      = require '../Token'
TokenTypes = require '../TokenTypes'
Cursor = require '../Cursor'

module.exports = \

##
# Cursor for navigating and manipulating plain text
class TextCursor extends Cursor

	@supportedTokens: [
		'char'
		'bword'
		'word'
		'line'
	]

	##
	#
	# @param {String} text
	constructor: ({@text, @pos}) ->
		@pos or= 0
		@_calculate_positions()

	cur: (tokenType) ->
		tokenType or= 'char'
		@positions[tokenType][@offsets[tokenType]] or null

	move : (amount, tokenType) ->
		@moveTo(@pos + amount, tokenType)

	moveTo : (pos, tokenType) ->
		tokenType or= 'char'
		if tokenType isnt 'char' then throw new Error("'moveTo' only implemented for 'char' at the moment.")
		# console.log "Moving to #{tokenType}##{pos}"
		@pos = pos
		@_calculate_offsets()

	del: (tobj) ->
		@text = @text.substring(0, tobj.index) + @text.substring(tobj.index + tobj.length)
		@_calculate_positions()
		return @

	ins: (tobj) ->
		@text = @text.substring(0, tobj.index) + tobj.text + @text.substring(tobj.index)
		@_calculate_positions()
		return @

	sub: (oldObj) ->
		with : (newObj) =>
			@del(oldObj)
			@ins(newObj, oldObj.index)
			return @

	next: (amount, tokenType) ->
		if amount and amount of TokenTypes then [amount, tokenType] = [1, amount]
		@_cur_plus_offset(tokenType, Math.abs amount)

	prev: (amount, tokenType) ->
		# XXX buggy
		if amount and amount of TokenTypes then [amount, tokenType] = [1, amount]
		@_cur_plus_offset(tokenType, -1 * Math.abs amount)

	atEOF : () -> return @pos == @text.length

	atSOF : () -> return @pos == 0

	#-------------------------------------------------
	#
	# Private API
	#
	#-------------------------------------------------

	_cur_plus_offset: (tokenType, offset) ->
		# if not currently in a  e.g. word, number, sentence ...
		curOffset = @offsets[tokenType]
		if curOffset?
			curOffset += offset
		else
			for idx, candidate of @positions[tokenType]
				if (offset > 0 and @pos >= candidate.index) or (offset < 0 and @pos < candidate.index + candidate.length)
					curOffset = candidate.index
			curOffset += offset
		@positions[tokenType][curOffset]

	_calculate_offsets : ->
		@offsets = {}
		@offsets.char = @pos
		for tokenType of TokenTypes
			continue if tokenType is 'char'
			for idx, candidate of @positions[tokenType]
				if @pos >= candidate.index and @pos < candidate.index + candidate.length
					@offsets[tokenType] = parseInt(idx)

	_calculate_positions : ->
		@positions = {}
		for tokenType, re of TokenTypes
			@positions[tokenType] = []
			while (group = re.exec(@text)) != null
				@positions[tokenType].push new Token(tokenType, group.index, group[0])
		@_calculate_offsets()
		return @

