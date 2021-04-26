---
layout: experiments
title: Trial information
section: experiments
---

# {{ page.title }}

The file `04_trials.js` supplies information necessary for the realization of your experiment's individual trials. For example, you would specify here which picture to show with which text on the screen to realize a particular experimental condition.

Trial information should be supplied in JSON-format, i.e., as an array of objects, each with the same properties. There can be different such arrays, which is useful if you have different types of trials. For example, the `04_trials.js`-file from the [Departure Point](https://github.com/magpie-ea/magpie-departure-point) looks like this:


```javascript
const trial_info = {
    forced_choice: [
        {
            question: "What's on the bread?",
            picture: "images/question_mark_02.png",
            option1: 'jam',
            option2: 'ham'
        },
        {
            question: "What's the weather like?",
            picture: "images/weather.jpg",
            option1: "shiny",
            option2: "rainbow"
        }
    ],
};
```

This file defines trial information for a forced choice task (more on these in the next section). There is information for two trials, since the array `forced_choice` has two elements each. For example, we define a URL for a different picture to show on each trial, as well as different labels for the response options in each trial. (How this information is used is easily seen when you just try out the experiment [here](https://magpie-departure-point.netlify.com).)
