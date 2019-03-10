---
layout: experiments
title: Trial randomization
section: experiments
---

# {{ page.title }}

Often, we would like to randomize the trial order in some way or other. In the Departure Point example, trials for the forced choice part are presented in an entirely random sequence for each realization of the experiment. This is realized in the file `views.js` when the view object is created, like so:

```javascript
const task_one_2AFC = babeViews.forcedChoice({
    (...)
    data: _.shuffle(part_one_trial_info.forced_choice)
});
```

In this way, trials are presented in a random order each time the experiment is started anew. The function `_.shuffle()` takes an array as input and returns a shuffled copy of that array. This function comes from the [lodash](https://lodash.com/) library, which is loaded by default. [lodash](https://lodash.com/) provides a number of useful convenience functions.

Compare this to the way in which the second part, the `multi-dropdown` receives its trial information:


```javascript
const task_two_sentence_completion = multiple_dropdown({
    (...)
    data: part_two_trial_info.multi_dropdown
});
```

Here, on randomization happens. Every participant will see the trials of this task in the exact same order, as specified in `trials.js`. 

If you want to realize more complex randomization schemes the functions from the [lodash](https://lodash.com/) library are very useful. 



