XRegExp = require('xregexp')

module.exports = \

##
# A bounded part of a text
class Token

	##
	# Create a new text object
	#
	# Parameters:
	#
	# @param {String} type type of text object
	# @param {String} index index of text object within containing text
	# @param {String} text string of this text
	# @see TokenTypes
	constructor: (@type, @index, @text) ->
		# Store the text length as the length property of the text object
		@length = @text.length

	##
	# Create a new text object that is identical to this one
	clone: ->
		return new @constructor(@type, @index, @text)

	##
	# Match a text object agains a pattern
	#
	# @param {String} pat A regular expression
	# @param {String} flag An XRegExp flag such as `g`
	match : (pat, flags) ->
		flags or= 'x'
		XRegExp.match @text, new XRegExp(pat, flags)

	##
	# Replace all occurrences of a regex
	replaceAll : (pat, replacement) ->
		@text = XRegExp.replace @text, new XRegExp(pat), replacement, 'all'
		# TODO
		return @

	##
	# Replace first occurrences of a regex
	replace : (pat, replacement) ->
		@text = XRegExp.replace @text, new XRegExp(pat), replacement
		# TODO
		return @

	##
	# Create a new Token that joins this and another Token
	#
	# * `other` (String|Token): Other text object or string
	join : (other) ->
		str = if typeof other is 'string' then other else other.text
		return new Token(@type, @index, @text + str)

	##
	# String.substr-like substring allowing negative indexes
	substr : (start, len) ->
		if start < 0
			start = @text.length + start
		len or= @text.length - start
		return @text.substr(start, len)

	##
	# Remove `n` characters from the left end (=beginning) of the text
	#
	# @param {Number} [n=1] Number of characters to remove
	removeLeft : (n) ->
		n or= 1
		return new Token(@type, @index, @text.substr(n))

	##
	# Remove `n` characters from the right end (=end) of the text
	#
	# @param {Number} [n=1] Number of characters to remove
	removeRight : (n) ->
		n or= 1
		max = if n < @text.length then @text.length - n else @text.length
		return new Token(@type, @index, @text.substr(0,max))
