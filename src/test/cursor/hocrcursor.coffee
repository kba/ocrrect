Test    = require 'tape'
HocrCursor = require '../../lib/cursor/HocrCursor'
Fs = require 'fs'

Test 'foo', (t) ->
	# Fs.readFile "#{__dirname}/../testdata/tess.hocr", (err, text) ->
	Fs.readFile "#{__dirname}/../../../testus/book.html", (err, text) ->
		cursor = new HocrCursor({text})
		console.log  cursor.doc.html.body[0].div[0].span.map ((x)->x.$)
		# parseString text, (err, result) ->
			# console.log result
		# c = new HocrCursor({text})
		# console.log c.$('.ocrx_word').eq(1).text()
		# # console.log "'#{c.$(".ocrx_word[21]")}'"
		t.end()
