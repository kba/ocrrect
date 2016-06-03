XRegExp = require('xregexp')

module.exports = class TextObject

	constructor: (@type, @index, @text) ->
		@length = @text.length

	clone: ->
		console.log 'yay'
		return new @constructor(@type, @index, @text)

	match : (pat) ->
		XRegExp.match @text, new XRegExp(pat, 'x')

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
