XRegExp = require('xregexp')

module.exports = class TextObject

	constructor: (@type, @index, @text) ->
		@length = @text.length

	clone: ->
		return new @constructor(@type, @index, @text)

	match : (pat, flags) ->
		flags or= 'x'
		XRegExp.match @text, new XRegExp(pat, flags)

	replaceAll : (pat, replacement) ->
		@text = XRegExp.replace @text, new XRegExp(pat), replacement, 'all'
		return @

	replace : (pat, replacement) ->
		@text = XRegExp.replace @text, new XRegExp(pat), replacement
		return @

	join : (other) ->
		str = if typeof other is 'string' then other else other.text
		return new TextObject(@type, @index, @text + str)

	substr : (start, len) ->
		if start < 0
			start = @text.length + start
		len or= @text.length - start
		return @text.substr(start, len)

	removeLeft : (n) ->
		n or= 1
		return new TextObject(@type, @index, @text.substr(n))

	removeRight : (n) ->
		n or= 1
		max = if n < @text.length then @text.length - n else @text.length
		return new TextObject(@type, @index, @text.substr(0,max))
