---
layout: docs
title: Experiments
section: docs
---

# {{ page.title }}


## Understanding counters

The sequence of views for an experiment is specified by the user in `exp.customize()`. The number of trials in each view are specified by the key `trials` of that view-object. On top of this, the user can specify loops of sequences (see below). To realize this, _babe uses a system of counters. It is good to understand the counter system for more advanced applications.

When a trial is finished _babe calls the function `exp.findNextView()`, which is defined in `main.js`, to decide what to show next in the sequence of views and trials. To do this, the `exp`-object has a property `exp.currentView` which just points to the current view-object. The `exp`-object also has two important counters, namely:

+ `exp.currentTrialCounter`: counts how many trials have passed during the whole experiment in total

+ `exp.currentTrialInViewCounter`: counts how many trials of the current view have passed already during the current block in which this view is shown repeatedly

Finally, there is also information about how many times a view has been shown already during the whole experiment. (A view can appear several times during an experiment, e.g., by using loops.) This information is not stored in the `exp`-object directly, but distributed as a property `CT` to each respective view. So, if we are interested in the number of times the current view has already occurred in the experiment so far in total, we find this number in `exp.views_seq[exp.currentViewCounter].CT`.

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

