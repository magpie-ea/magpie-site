---
layout: experiments
title: Trial information & randomization
section: experiments
---

# {{ page.title }}

Trial information can, for example, be supplied as an array of objects, as in `trial_info/main_trials.js`, the content of which is:

```javascript
var main_trials = [
	{question: "How are you today?", 
	 option1: "fine", 
	 option2: "great", 
	 picture: "images/question_mark_01.png"},
	{question: "What is the weather like?", 
	 option1: "shiny", 
	 option2: "rainbow", 
	 picture: "images/question_mark_02.png"},
];
```

This file defines that there are two types of trials which differ in a number of relevant pieces of information, such as the URL to a picture which will be shown, a question asked and two answer alternatives. If your experiment contains several different types of trials, we recommend supplying their information in separate files, like the minimal template does for practice trials and main trials. There is also the possibility to load trial information from a CSV file and you may also obtain it from a data base, using the server app. (INFORMATION TO BE ADDED SOON.)

Normally, we would like to randomize the trial order in some way or other. This is what happens inside of `exp.customize()`, where we have:

```javascript
this.trial_info.main_trials = _.shuffle(main_trials)
```

In this way, the main trials are presented in a random order each time the experiment is started anew. The function `_.shuffle()` takes an array as input and returns a shuffled copy of that array. This function comes from the [lodash](https://lodash.com/) library, which is loaded by default. [lodash](https://lodash.com/) provides a number of useful convenience functions.


