module.exports = class HyphenationRule

	# match : (c) ->
	#   c.cur('bword').match("\\d") and
	#   c.next('char').match(/\n/) and
	#   c.cur('bword')             and
	#   c.cur('bword').length > 1

	# fix : (c) ->
	#   # remember line/page separator
	#   oldSep = c.next('char')
	#   c.sub(c.cur('bword')).with(
	#     c.cur('bword').clone()   # clone the current word
	#       .removeRight(1)        # remove the '-'/'='
	#       .join(c.next('bword')) # join the next word
	#   )
	#   # Delete the next word
	#   c.del c.next('word')


