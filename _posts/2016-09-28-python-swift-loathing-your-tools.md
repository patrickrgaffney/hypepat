---
title: "Python & Swift: Loathing Your Tools"
layout: post
date: 2016-09-28
tags: swift, python, macos
published: true
summary: Yet another reason why we should all stop using Python 2.7.x.
---

Here is a fun way to waste some time: ensure that you have Python 2.7.12 [^python] installed on your Mac via homebrew or whatever, then launch the swift REPL. You can do this now by just typing `swift`. Your welcome.

[^python]: As of writing this, that is the latest version of Python on the 2.7.x track. Really, all you need for this little adventure is for the `python` binary to *not* be the default shipped with macOS.

```bash
Traceback (most recent call last):
  File "<string>", line 1, in <module>
  File "/Applications/Xcode.app/Contents/SharedFrameworks/LLDB.framework/Resources/Python/lldb/__init__.py", line 98, in <module>
    import six
ImportError: No module named six
Traceback (most recent call last):
  File "<string>", line 1, in <module>
NameError: name 'run_one_line' is not defined
Traceback (most recent call last):
  File "<string>", line 1, in <module>
NameError: name 'run_one_line' is not defined
Traceback (most recent call last):
  File "<string>", line 1, in <module>
NameError: name 'run_one_line' is not defined
```

That nonsense will fill your terminal faster than you can even hit `Control-D`. It could almost be a game &mdash; count the number of `NameError` dialogs, the lower number wins. I call it... `NameError` golf.

Well what's going on here? If you go all the way back to the top of what is now the longest terminal session in history &mdash; back to when you typed in `swift` &mdash; you will see the first `Traceback`. Ahh, it appears [LLDB][lldb] runs some Python script when starting the Swift REPL. And somewhere in that file an attempt is made to load the `six` module.

What the hell is the `six` module, and why do I care?

The `six` module &mdash; and now I'm just going to quote from [the package site][six] &mdash; "provides simple utilities for wrapping over differences between Python 2 and Python 3."

Yes, that's right. The culprit is a module that makes it easier to write Python 2 code. Ughhhh.

## Fixing This "Problem"

The reason I am getting this error message &mdash; in case you already haven't guessed &mdash; is because I have Python 2.7.12 installed. It's from homebrew. I'm fairly sure that I got it back before 2.7.10 and it's just been updating itself everytime I `brew update; brew upgrade`.

For reasons which I won't go into now I have my homebrew Python binary ahead of my macOS default Python binary in the `$PATH`. I also don't have the `six` module installed for that binary. Normally this isn't a problem for me because I try my damnest to write everything in Python 3.

So, you can solve this problem by doing one of two things:

1. `brew uninstall python`
2. `pip install six`

I chose the first option, because it's time to [stop living in the past][py23].

[lldb]: http://lldb.llvm.org
[six]: http://pythonhosted.org/six/
[py23]: https://wiki.python.org/moin/Python2orPython3