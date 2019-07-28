---
layout: experiments
title: Trial sequencing, loops &amp; randomization
section: experiments
---

# {{ page.title }}

Once you have defined suitable views as the building blocks of your experiment, you want to arrange them in the order that they should show up each time the experiment is instantiated. In the simplest case, you would just provide a simple linear structure, like in the [Departure Point](https://github.com/magpie-ea/magpie-departure-point):

```javascript
views_seq: [
    intro,
    instructions,
    forced_choice_2A,
    post_test,
    thanks,
]
```

But more advanced, sequencing of views can also be realized. Suppose you have an experiment where a sequence of views is to be repeated many times in a loop. For example, your main trials could consist of three types of displays: (i) get ready, (ii) do task and (iii) receive feedback. To implement this, _magpie supplies a convenience function `loop(array, count)` which you can use in `magpieInit()` when you supply a view sequence. You could then write code like this:

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
