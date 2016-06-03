## Hyphenation Rule

* match(cursor)
  * cursor.current('char').match(/-|=/)
  * cursor.next('char').match(/\n/)
  * cursor.current('word').length > 1
* fix(cursor)
  * cursor.current('char').delete()
  * cursor.next('char').delete()
