##
# Basic units of text that are implemented by a TextObject and can be be used
# by a Cursor.
#
# @see Cursor
# @see TextObject
#
# @module TextObjectTypes
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
