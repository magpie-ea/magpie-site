---
layout: docs
title: Experiments
section: docs
---

# {{ page.title }}

{% include toc.html %}


## Advanced sequencing: looping and shuffling views

Suppose you have an experiment where a sequence of views is to be repeated many times in a loop. For example, your main trials could consist of three types of displays: (i) get ready, (ii) do task and (iii) receive feedback. To implement this, _babe supplies a convenience function `loop(array, count)` which you can use in `exp.customize()`. You could then write code like this:

```javascript
views_seq = [intro,
             practice,
             loop([getReady, doTask, receiveFeedback], 3),
             postSurvey,
             thanks]
```

Behind the scenes, this is processed to result in the following sequence:

```javascript
views_seq = [intro,
             practice,
             getReady, doTask, receiveFeedback, // # 1
             getReady, doTask, receiveFeedback, // # 2
             getReady, doTask, receiveFeedback, // # 3
             postSurvey,
             thanks]
```

It is possible to nest `loop()` calls at arbitrary depth. For example:

```javascript
views_seq = [intro,
             practice,
             loop([loop([getReady, doTask],2), receiveFeedback], 3),
             postSurvey,
             thanks]
```

This is equivalent to writing:

```javascript
views_seq = [intro,
             practice,
             getReady, doTask,
             getReady, doTask, receiveFeedback, // # 1
             getReady, doTask,             
             getReady, doTask, receiveFeedback, // # 2
             getReady, doTask,
             getReady, doTask, receiveFeedback, // # 3
             postSurvey,
             thanks]
```
