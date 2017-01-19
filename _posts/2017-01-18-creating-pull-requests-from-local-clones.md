---
title: Creating Pull Requests from Local Clones
layout: post
date: 2017-01-18
tags: [git, github]
published: true
summary: Or, why you should always fork.
---

Here is a workflow I often find myself in: 

- I want to test out a potential solution some open source project offers.
    - *Alternatively*, I am about to begin work on a legacy project at work and want to check out the code before I get commit access.
- I clone the repository to play with it.
- I notice a bug or a simple feature that's missing.
- I make a new branch and fix/add the bug/feature.
- I push the new branch to a new repository on *my* Github.
- Github has no idea I began this process by cloning --- therefore it's impossible to create a pull request.
- WTFFFFFF 😡❗️😤‼️😩⁉️😫❓😖

The simple solution: **just fork it**.  If I had made a fork in the beginning instead of cloning someone else's repository, my new branch would have been evidence enough for Github to give me the opportunity to make a pull request.

There is a way to get out of this mess, but you still have to create a fork.  Lets jump back to when I checked-out a new branch and committed some changes.

> - I make a new branch and fix/add the bug/feature.

At this point, we have to tell Github that we actually *forked* this repository:

- Go to the original repository on Github and fork it.
- Rename the remote (base repository) in your local clone from `origin` to `upstream`.

        git remote rename origin upstream

- Add **your fork** to as a remote --- the `origin` --- on your local clone.

        git remote add origin <link-to-your-forked-repo>

- Push the new branch to **your forked repository**.

        git push --all

- Go to your forked repository on Github and switch to the new branch.
- Create the pull request.
- Take a deep breath. 