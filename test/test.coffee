Test    = require 'tape'
Cursor  = require '../src/Cursor'
XRegExp = require 'xregexp'

text = 'one, two three\n4our'

Test 'xregexp', (t) ->
	re = new XRegExp("\\d", "g")
	t.equals XRegExp.match("123l2", re).length, 4, 'four matches'
	t.end()

Test 'cursor basics', (t) ->
	c = new Cursor(text)
	t.equals c.positions.char.length, text.length, 'char length'
	t.equals c.positions.word.length, 4, 'word length'
	t.equals c.positions.bword.length, 4, 'bword length'
	t.equals c.positions.word[0].text, 'one', 'word[0] == "one"'
	t.equals c.positions.bword[0].text, 'one,', 'bword[0] == "one,"'
	t.equals c.positions.bword.length, 4, 'bword.length == 4'

	text_before = c.text
	first_bword = c.positions.bword[0]

	t.test 'ins/del', (tt) ->
		c.del(first_bword)
		t.equals c.positions.bword.length, 3, 'after del bword.length == 3'
		c.ins(first_bword, 0)
		t.equals c.positions.bword.length, 4, 'after ins bword.length == 4'
		t.equals c.text, text_before
		tt.end()

	t.test 'sub/with', (tt) ->
		t.equals typeof c.sub(first_bword).with, 'function', "'sub' returns an object {with: [function]}"
		c.sub(first_bword).with(first_bword.removeLeft(1))
		t.equals c.positions.bword.length, 4, 'after ins bword.length == 4'
		t.equals c.positions.bword[0].text, 'ne,', 'bword[0] == "ne,"'
		tt.end()

	t.end()


Test 'cur / move / next / prev', (t) ->
	c = new Cursor(text)
	t.equals c.cur('char').text, text.substr(0,1), "cur('char') == 'o'"
	t.equals c.cur('word').text, 'one', "cur('word') == 'one'"
	c.move(4)
	t.equals c.cur('word'), null, "+ 4 => cur('word') == null"
	t.equals c.next('word').text, 'two', "next('word') == 'two'"
	t.equals c.next(2, 'word').text, 'three', "next(2, 'word') == 'three'"
	c.move(1)
	t.equals c.cur('word').text, 'two', "+ 5 => cur('word') == 'two'"
	t.end()

Test 'hyphenation rule', (t) ->
	hypRule = new (require '../src/rules/hyphenation')
	text = 'foo-\nbar'
	c = new Cursor(text, 3)
	t.ok hypRule.match(c), 'hyphenation rule matches'
	hypRule.fix(c)
	t.equals c.text, 'foobar\n', 'hyphenation fix succeeded'
	t.end()

Test.only 'letter-in-number rule', (t) ->
	rule = new (require '../src/rules/letter-in-number')
	text = '1234l3'
	c = new Cursor(text)
	t.ok rule.match(c), 'rule matches'
	rule.fix(c)
	t.equals c.text, '123413', 'fix succeeded'
	t.end()
# testWordCursor()
