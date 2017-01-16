---
title: Removing a File from All past Git Commits
layout: post
date: 2017-01-16
tags: [git]
published: true
summary: Because we all forget to ignore .DS_Store sometimes.
---

I have a tendency not to add `.DS_Store` to my `.gitignore` until I've already pushed to Github. Every single goddamn time it happens, I have to spend ten minutes googling for the answer.

Well, [here be dragons][dragons]:

```bash
git filter-branch --index-filter 'git rm --cached --ignore-unmatch .DS_Store' HEAD
```

- The `filter-branch` [command][filter-branch] rewrites commit history based on the filter that you provide. 
- The `--index-filter` tells git to rewrite the index &mdash; it doesn't check out the tree, which is [apparently faster][faster]. 
- The filter we're passing tells git to remove the `.DS_Store` from the staging area and delete it's paths from the index &mdash; aka `--cached`. 
- The `ignore-unmatch` flag does exactly that, the remove command exits with a 0 status even if no matches were found.

May the git lords have pity on your soul.


[dragons]: https://en.wikipedia.org/wiki/Here_be_dragons
[filter-branch]: https://git-scm.com/docs/git-filter-branch
[faster]: https://git-scm.com/docs/git-filter-branch#git-filter-branch---index-filterltcommandgt