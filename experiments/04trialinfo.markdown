---
layout: experiments
title: Trial information
section: experiments
---

# {{ page.title }}

The file `trials.js` supplies information necessary for the realization of your experiments individual trials. For example, you would specify here which picture to show with which text on the screen to realize a particular experimental condition.

Trial information should be supplied in JSON-format, i.e., as an array of objects, each with the same properties. There can be different such arrays, which is useful if you have different types of trials. For example, the `trials.js`-file from the [Departure Point](https://github.com/babe-project/departure-point) looks like this:


```javascript
const part_one_trial_info = {
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
}

const part_two_trial_info = {
    multi_dropdown: [
        {
            sentence_chunk_1: "Some of the",
            sentence_chunk_2: "are",
            sentence_chunk_3: "today.",
            choice_options_1: ["cats", "dogs"],
            choice_options_2: ["happy", "hungry", "sad"]
        },
        {
            sentence_chunk_1: "All of the",
            sentence_chunk_2: "will be",
            sentence_chunk_3: "tomorrow.",
            choice_options_1: ["cats", "dogs"],
            choice_options_2: ["happy", "hungry", "sad"]
        }
    ]
}
```

This file defines trial information for two different tasks (more on these in the next section). For each task, there is information for two trials, since the arrays `forced_choice` and `multi_dropdown` have two elements each. For example, for the `forced_choice` task we define a URL for a different picture to show on each trial, as well as different labels for the response options in each trial. For the `multi_dropdown` task we define different stimulus sentence chunks. (How this information is used is easily seen when you just try out the experiment [here](https://departure-point.netlify.com).)
