BaseRule = require './BaseRule'

module.exports =\

##
# Rule for matching and fixing hyphenated lines
class HyphenationRule extends BaseRule

	##
	# * the current character is either '-' or '=' and
	# * the next character is a newline or a page feed
	# * the word ending with '-'/'=' is longer than 1 char
	#
	match : (c) ->
		c.cur('char').match("-|=") and
		c.next('char').match("\\n|\\f") and
		c.cur('bword') and c.cur('bword').length > 1

	##
	# Strip the hyphenation character and join word on following line with
	# current word.
	fix : (c) ->
		# remember line/page separator
		oldSep = c.next('char')
		c.sub(c.cur('bword')).with(
			c.cur('bword').clone()   # clone the current word
				.removeRight(1)        # remove the '-'/'='
				.join(c.next('bword')) # join the next word
		)
		# Delete the next word
		c.del c.next('bword')

