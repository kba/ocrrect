TextObject      = require './TextObject'
TextObjectTypes = require './TextObjectTypes'

NON_TEXT_OBJECT = new TextObject('none', -1, '')

module.exports = \

##
# Cursor for navigating and manipulating text
class Cursor

	##
	# Create a new cursor over a text
	#
	# @param {String} text Text to traverse
	# @param {String} [pos=0] - foo
	constructor: (@text, @pos) ->
		@pos or= 0
		@_calculate_positions()

	_calculate_offsets : ->
		@offsets = {}
		@offsets.char = @pos
		for tobjType of TextObjectTypes
			continue if tobjType is 'char'
			for idx, candidate of @positions[tobjType]
				if @pos >= candidate.index and @pos < candidate.index + candidate.length
					@offsets[tobjType] = parseInt(idx)

	_calculate_positions : ->
		@positions = {}
		for tobjType, re of TextObjectTypes
			@positions[tobjType] = []
			while (group = re.exec(@text)) != null
				@positions[tobjType].push new TextObject(tobjType, group.index, group[0])
		@_calculate_offsets()
		return @

	##
	# Delete a text object
	del: (tobj) ->
		@text = @text.substring(0, tobj.index) + @text.substring(tobj.index + tobj.length)
		@_calculate_positions()
		return @

	##
	# Insert a text object
	ins: (tobj) ->
		@text = @text.substring(0, tobj.index) + tobj.text + @text.substring(tobj.index)
		@_calculate_positions()
		return @

	##
	# Replace a text object
	sub: (oldObj) ->
		with : (newObj) =>
			@del(oldObj)
			@ins(newObj, oldObj.index)
			return @

	##
	# Move the current position relative to the current position.
	# @param {Number} amount Number of units to move (can be negative)
	# @param {String} [tobjType='char'] Text object type
	# @see TextObjectTypes
	move : (amount, tobjType) ->
		@moveTo(@pos + amount, tobjType)

	##
	# Move the current position to an absolute position
	# @param {Number} pos Position to move to
	# @param {String} [tobjType='char'] Unit to measure movements
	moveTo : (pos, tobjType) ->
		tobjType or= 'char'
		if tobjType isnt 'char' then throw new Error("'moveTo' only implemented for 'char' at the moment.")
		# console.log "Moving to #{tobjType}##{pos}"
		@pos = pos
		@_calculate_offsets()

	##
	# Get the text object at the current cursor position
	# @param {String} [tobjType='char'] The text object type to get
	cur: (tobjType) ->
		tobjType or= 'char'
		@positions[tobjType][@offsets[tobjType]] or null

	_cur_plus_offset: (tobjType, offset) ->
		# if not currently in a  e.g. word, number, sentence ...
		curOffset = @offsets[tobjType]
		if curOffset?
			curOffset += offset
		else
			for idx, candidate of @positions[tobjType]
				if (offset > 0 and @pos >= candidate.index) or (offset < 0 and @pos < candidate.index + candidate.length)
					curOffset = candidate.index
			curOffset += offset
		@positions[tobjType][curOffset]

	next: (amount, tobjType) ->
		if amount and amount of TextObjectTypes then [amount, tobjType] = [1, amount]
		@_cur_plus_offset(tobjType, Math.abs amount)

	# prev: (amount, tobjType) ->
	#   if amount and amount of TextObjectTypes then [amount, tobjType] = [1, amount]
	#   @_cur_plus_offset(tobjType, -1 * Math.abs amount)

	##
	# Whether the cursor is at the end of the text.
	# @return {Boolean} whether the cursor is at the end of the text.
	atEOF : () -> return @pos == @text.length

	##
	# whether the cursor is at the start of the text.
	# @return {Boolean} whether the cursor is at the start of the text.
	atSOF : () -> return @pos == 0
