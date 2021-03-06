BaseRule = require './BaseRule'

module.exports =\

##
# Rule for matching letters in sequences of numbers
class LetterInNumberRule extends BaseRule

	match : (c) ->
		digits = c.cur('bword').match("\\d")
		letters = c.cur('bword').match("\\P{Letter}")
		digits and letters # and digits.length > letters.length

	fix : (c) ->
		c.sub(c.cur('bword')).with(
			c.cur('bword').clone()   # clone the current word
				.replaceAll("[^\\d]", (letter) ->
					return if letter is 'l' then 1 else letter
				))

