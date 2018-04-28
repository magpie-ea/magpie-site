---
layout: docs
title: Experiments
section: docs
---

# {{ page.title }}

{% include toc.html %}


## Advanced sequencing of views

### Loops

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

### Shuffles & shuffled loops

It is, of course, also possible to shuffle views if they are supposed to come in arbitrary order:

```javascript
views_seq = [intro,
             practice,
             _.shuffle([task1, task2]),
             postSurvey,
             thanks]
```

In this example it is a random choice whether `task1` precedes `task2` or vice versa. The convenience function `loopShuffle` combines loops and random view sequences. For example, if you want to have three repetitions of a block, each of which contains `task1` and `task2` with each occurrence in a fresh random order, you can use:

```javascript
loopShuffle([task1, task2], 3),
```

