---
title: Pinned Tabs in Safari 9
layout: post
date: 2015-10-05 21:50
tags: safari, el capitan
published: true
summary: Update your website to work with Pinned Tabs in Safari 9.
---

[Safari 9.0][safari] shipped last week with the release of [El Capitan][el-cap].  This version is largely a [feature release][safari-rel-notes] -- last year Safari got it's root canal, now it's time for a cleaning.

By far, the [most][content1] [talked][content2] [about][content3] component of Safari 9 was the content blocking extensions it brought to iOS.  Although this is big news, there are plenty of other features tucked away in the [release notes][safari-rel-notes].  In no particular order, Safari added:

- a Force Touch Trackpad Events API
- Airplay of HTML5 media to your Apple TV
- a `SFSafariViewController` to replace the troubled `UIWebView`
- CSS Scroll Snapping
- CSS Backdrop filters [^filters]
- a redesign of the Web Inspector
    - including [Responsive Design Mode][responsive-d-mode]
- ECMAScript 6 enhancements
- support for the use of system fonts in CSS
- support for a handful of CSS4 selectors
- "pinned tab" support

Of these, **pinned tabs** is the most user-facing feature, and it adds some additional markup.  This is something [Firefox][firefox-tabs] and [Chrome][chrome-tabs] have had for awhile now, and it comes to Safari with a few idiosyncrasies you will want to familiarize yourself with.

## The Gist

Pinned tabs in Safari work similarly to Chrome or Firefox.  Open up a tab in Safari, pin it to your tab bar, and it will remain active in the background.  This is most useful for sites that you routinely visit, and would rather keep open and running on the left side of your tab bar.  There is currently no shortcut for this functionality, but you can command-click your tab and choose "Pin Tab" or accomplish this via Window → Pin Tab.

![Pinned Tabs Example][pin-tabs-ex]

Once a tab is pinned, you cannot close it.  Go ahead, give it a try.  Nope, `⌘W` just takes you to the first un-pinned tab.  Ixnay on File → Close Window as well, that might close the window, but open up another window and you'll see you didn't get very far.  Well what about `⌘Q`?  Surely if I quit the damn application all these pinned things are gone.  Negative, now this is just getting annoying.

The only way to close a tab, once pinned, is to un-pin it.  You can accomplish this via command-click, or venture back to Window → Unpin Tab.

## The Implementation

On Chrome and Firefox, the pinned tabs use the websites [favicon][favicon] as its placeholder image in their respective tab bars.  But this is Apple, and similar to the [Web Clip icon][web-clip], they want you to add another `link` tag to your page header.  

Without the additional markup, your site's icon will appear as a square with the first letter of your domain capitialized.  Safari does choose a color from your site as the background for this square, but it is still worth changing. [^default-icon]

The format for the markup looks like the following:

```html
<link rel="mask-icon" href="website_icon.svg" color="red">
```

The image in question must be a 100% black vector image with a transparent background.  Safari is pretty strict on this, try and use a color other than black, and you'll be stuck with the default image.  You can change the color of the non-transparent part of your `SVG` using the `color` attribute.  It will take a hex value, RGB value, or a recognized color-keyword, such as `black`.

If you're on a Mac and you need a good application for creating `SVG` images, take a look at [Sketch 3][sketch].  Don't let the price fool you, it's very fair for the application you're getting.  And there is a trial on their website.

Safari does keep a cache of all the `mask-icon` images it comes across in `~/Library/Safari/Template Icons`.  If you notice that your icon isn't updating while you're testing it, you might want to delete the contents of that folder and restart Safari. 

That's it!  Drop that `SVG` in your root directory, add that tag to your page, and stare in awe at the amount of WebKit-specific tags in your header.

[^filters]: And, Safari is the [first major browser][caniuse-bd-filters] to implement the Backdrop filters outlined in a [W3C draft][wsc-bd-filters] last fall.  So much for [all that hype][safari-new-ie].

[^default-icon]: Best I can tell, it uses the contents of the first element's `background-color`.  Although this is 100% guesswork based on limited to no facts.  In other words, I'm positive that's what it's doing.

[safari]: https://www.apple.com/safari/
[el-cap]: https://www.apple.com/osx/
[safari-rel-notes]: https://developer.apple.com/library/prerelease/mac/releasenotes/General/WhatsNewInSafari/Articles/Safari_9.html
[content1]: http://www.macworld.com/article/2984483/ios/hands-on-with-content-blocking-safari-extensions-in-ios-9.html
[content2]: http://thenextweb.com/apple/2015/08/24/ios-9-content-blocking-will-transform-the-mobile-web-ive-tried-it/
[content3]: http://techcrunch.com/gallery/everything-you-need-to-know-about-ios-9s-new-content-blockers/
[caniuse-bd-filters]: http://caniuse.com/#feat=css-backdrop-filter
[wsc-bd-filters]: https://drafts.fxtf.org/filters-2/#BackdropFilterProperty
[safari-new-ie]: http://nolanlawson.com/2015/06/30/safari-is-the-new-ie/
[responsive-d-mode]: http://www.mcelhearn.com/use-safaris-responsive-design-mode-in-el-capitan/
[firefox-tabs]: https://support.mozilla.org/en-US/kb/pinned-tabs-keep-favorite-websites-open
[chrome-tabs]: https://support.google.com/chrome/answer/95622?hl=en
[web-clip]: https://developer.apple.com/library/prerelease/ios/documentation/AppleApplications/Reference/SafariWebContent/ConfiguringWebApplications/ConfiguringWebApplications.html#//apple_ref/doc/uid/TP40002051-CH3-SW4
[favicon]: https://en.wikipedia.org/wiki/Favicon
[sketch]: http://www.sketchapp.com

[pin-tabs-ex]: /images/pinned_tabs.png