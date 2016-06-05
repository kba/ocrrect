module.exports =\

##
# Abstract base class for all rules.
class BaseRule

	##
	# Test whether the rule matches at the cursor position.
	#
	# @param {Cursor} c cursor to match against
	# @returns {Boolean} Whether the cursor position is matched by the rule
	match: (c) ->
		throw new Error("'match' not implemented")

	##
	# Fix the text by manipulating the cursor.
	#
	# @param {Cursor} c cursor to use as interface to text
	fix: (c) ->

