Test    = require 'tape'
HocrCursor = require '../../lib/cursor/HocrCursor'
Fs = require 'fs'

Test 'foo', (t) ->
	Fs.readFile "#{__dirname}/../testdata/tess.hocr", (err, text) ->
		c = new HocrCursor({text})
		console.log c.$('.ocrx_word').eq(1).text()
		# console.log "'#{c.$(".ocrx_word[21]")}'"
		t.end()
