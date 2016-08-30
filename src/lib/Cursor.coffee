Token      = require './Token'
TokenTypes = require './TokenTypes'

module.exports = \

##
# Base class of cursors
class Cursor

	##
	# Delete a text object
	del: (tobj) -> throw new Error("Not implemented: #{constructor.name}.del")

	##
	# Insert a text object
	# @param
	# @return
	ins: (tobj) -> throw new Error("Not implemented: #{constructor.name}.del")

	##
	# Replace a text object
	sub: (oldObj) -> throw new Error("Not implemented: #{constructor.name}.sub")

	##
	# Move the current position relative to the current position.
	# @param {Number} amount Number of units to move (can be negative)
	# @param {String} [tobjType='char'] Text object type
	# @see TokenTypes
	move : (amount, tobjType) -> throw new Error("Not implemented: #{constructor.name}.move")

	##
	# Move the current position to an absolute position
	# @param {Number} pos Position to move to
	# @param {String} [tobjType='char'] Unit to measure movements
	moveTo : (amount, tobjType) -> throw new Error("Not implemented: #{constructor.name}.moveTo")

	##
	# Get the text object at the current cursor position
	# @param {String} [tobjType='char'] The text object type to get
	cur : (amount, tobjType) -> throw new Error("Not implemented: #{constructor.name}.cur")

	##
	# Get the n-th next token of this type.
	# @param {Number} [amount=1] The n-th next, defaults to first
	# @param {String} [tobjType='char'] The text object type to get
	next : (amount, tobjType) -> throw new Error("Not implemented: #{constructor.name}.next")

	##
	# Get the n-th previous token of this type.
	prev : (amount, tobjType) -> throw new Error("Not implemented: #{constructor.name}.prev")
	#   if amount and amount of TokenTypes then [amount, tobjType] = [1, amount]
	#   @_cur_plus_offset(tobjType, -1 * Math.abs amount)

	##
	# Whether the cursor is at the end of the text.
	# @return {Boolean} whether the cursor is at the end of the text.
	atEOF : (amount, tobjType) -> throw new Error("Not implemented: #{constructor.name}.atEOF")

	##
	# whether the cursor is at the start of the text.
	# @return {Boolean} whether the cursor is at the start of the text.
	atSOF : (amount, tobjType) -> throw new Error("Not implemented: #{constructor.name}.atSOF")
