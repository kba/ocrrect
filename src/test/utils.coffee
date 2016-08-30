Test = require 'tape'
Utils = require '../src/Utils'

Test 'uriToFilename', (t) ->
	t.equals Utils.uriToFilename('http://foo/bar/quux_baz.csv'), 'foo_bar_quux_baz_csv', 'uriToFilename as expected'
	t.end()


