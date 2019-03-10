---
layout: experiments
title: Trial randomization
section: experiments
---

# {{ page.title }}

In the Departure Point example, trials for the first part (forced choice) are presented in a fixed order: every participant will always see the trials in exactly the order defined in `trials.js`. This is because we supplied the trial data like so in the file `views.js`:

```javascript
const task_one_2AFC = babeViews.forcedChoice({
    (...)
    data: part_one_trial_info.forced_choice
});

```

Often, we would like to randomize the trial order in some way or other. One simple way of doing this is to present trials  in an entirely random sequence for each realization of the experiment. This is realized in the Departure Point in the file `custom_views.js` where we instantiate the custom view type `multi_dropdown`:

```javascript
const task_two_sentence_completion = multiple_dropdown({
    (...)
    data: _.shuffle(part_two_trial_info.multi_dropdown)
});

```

Here, trials are presented in a random order each time the experiment is started anew. The function `_.shuffle()` takes an array as input and returns a shuffled copy of that array. This function comes from the [lodash](https://lodash.com/) library, which is loaded by default. [lodash](https://lodash.com/) provides a number of useful convenience functions.

If you want to realize more complex randomization schemes the functions from the [lodash](https://lodash.com/) library are very useful. Simply massage your trials into the desired shape before creating your view instances.



