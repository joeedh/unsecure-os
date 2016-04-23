/*

a hierachy of document clipboard types:
//note: no fancy rendering of e.g. list bullets to unicode
//      I can't stand that, people should support rtf, tex, or html. 
//      there are three of them!

    raw text <-
 -> tex  <-   |
 |  rtf   |   |
    html  |   |
    image     |
   
so, html/rtf can convert to tex, which can convert to text.
tex can also convert to rtf and html.  so when you load in
html, it will be converted to tex; when you load in tex, it
will render html.

images are a bit special; they can convert to text via their accessibility tags,
as well as html, rtf, and tex
*/

//hrm.  html can have binary blobs via data url.  rtf supports that natively.
//I believe tex does to, need to look up.

