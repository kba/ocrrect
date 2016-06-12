##
# Basic units of text that are implemented by a Token and can be be used
# by a Cursor.
#
# @see Cursor
# @see Token
#
# @module TokenTypes
module.exports =

	##
	# @property {RegExp} char character, which includes whitespace and newlines
	'char': new RegExp('[\\s\\S]', 'g')

	##
	# @property {RegExp} word word in the sense of regular expression word boundaries
	'word': new RegExp('\\b[^\\s]+?\\b', 'g')

	##
	# @property {RegExp} bword word in the sense of "consecutive non-whitespace"
	'bword': new RegExp('\\S+', 'g')

	##
	# @property {RegExp} line Everything between newlines
	'line': new RegExp('[^\\n]+', 'g')
