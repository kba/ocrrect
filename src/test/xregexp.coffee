Test    = require 'tape'
XRegExp = require 'xregexp'

Test 'xregexp', (t) ->
	re = new XRegExp("\\d", "g")
	t.equals XRegExp.match("123l2", re).length, 4, 'four matches'
	t.end()

