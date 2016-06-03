* Text is a finite stream of text objects (must be finite because of multiple passes)
* Text objects can be
  * line
  * word (different definitions of word!)
  * character class
* Rules define depending on context
* Correction happens in multiple passes
* Text is traversed by a Cursor
  * Can always look ahead / look behind from cursor
* Cursor has
  * line : LineObject
    * 
  * word
  * next
