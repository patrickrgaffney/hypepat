Title: TextMate's Markdown Headings
Date: 2015-10-26 23:46
Tags: textmate, markdown, editors
Slug: textmates-markdown-headings
Status: published
Summary: Tinkering with the way TextMate renders markdown heading elements inside the editor.

One of the things I initially disliked about TextMate's [Markdown bundle][markdown] is the way it handles headings inside the editor.  I don't mind the *largeness* of the elements -- these are headings, chances are they are going to be large when rendered on a website or published in a document.

![You should really read The Martian][the_martian]
{.wide}

I cannot stand that font.

It just doesn't play well with the monospace font I use, [Office Code Pro][monospace].  The headings look *very* thin, and I spend a lot of my time writing things in markdown.  I can't stare at these goddamn headings anymore.

Luckily, this is [TextMate][philosophy], so chances are there is a setting we can update to reflect my stubbornness. 

Buried inside the "Themes" bundle [^default] are a group of settings that control this, aptly named "Markup: Heading X".  Basically, each of these is a simple [TextMate Settings][settings] file that sets options for selected [scopes][scopes]. [^tm-settings]

[^default]: This is one of those default, *meta* bundles that comes preinstalled with TextMate.  They typically contains items that other bundles use.  For example, inside this bundle are the themes used to render the [HTML output][html-out].

[^tm-settings]: Yes, I have written about [TextMate settings before][python-post].  Thanks for asking.

![TextMate's Theme Bundle][themes-settings]
{.wide}

In the [drawer][drawer] on the left the *Scope Selector* is set to `markup.heading.x`.  This tells TextMate to only trigger this setting when inside that particular scope.  The setting itself is rather simple -- all it changes are the `fontSize` and `fontName` attributes.  It seems the perpetrator in question goes by the name "Baskerville".

Well, time for a face lift.  I'm going to change this to [PT Serif][pt-serif], because in this blogger's opinion, it's a superior font in literally every way. [^blog-font]

[^blog-font]: I like it so much, I use it exclusively on this blog (save for the code samples).

![Rollin thru the 6ix with my sol][updated_martian]
{.wide}

Just look at those pound signs. [^hashtags]  Now *that* is a font worthy of a heading.

[^hashtags]: Err... Hashtags, I mean.

[markdown]: https://github.com/textmate/markdown.tmbundle
[monospace]: https://github.com/nathco/Office-Code-Pro
[philosophy]: http://manual.macromates.com/en/preface#philosophy_of_textmate
[html-out]: http://manual.macromates.com/en/commands#html_output
[settings]: http://wiki.macromates.com/Reference/Settings
[scopes]: http://manual.macromates.com/en/scope_selectors#scope_selectors
[python-post]: http://hypepat.com/2015/python-in-textmate.html
[pt-serif]: http://brick.im/fonts/ptserif/
[drawer]: https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/Drawers/Drawers.html

[the_martian]: /images/the_martian_headings.png
[themes-settings]: /images/markdown_headings_settings.png
[updated_martian]: /images/updated_martian_headings.png