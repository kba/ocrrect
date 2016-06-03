module.exports = 
	'char':  new RegExp('[\\s\\S]',       'g')
	'word':  new RegExp('\\b[^\\s]+?\\b', 'g')
	'bword': new RegExp('\\S+',           'g')
	'line':  new RegExp('[^\\n]+',        'g')
