---
layout: getting-started
title: Experiments
section: start
---

# {{ page.title }}

This guide walks through the minimal template, which you can [obtain here](../obtain.html), so that you can use it as a starting point of your own experiments. A full and extensive documentation is in the [docs](../docs/experiments.html).

{% include toc.html %}



## File structure

The minimal template contains the following files, of which the ones marked with **->** are most important for everyday use:

+ **->`index.html`** - starting point; loads all relevant files; provides view-templates;
+ **->`config/config_deploy.js`**  - information about how to deploy (=run, collect data for) the experiment
+ **->`views/views.js`** - provides the view-objects; main work happens here
+ `scripts/`
	+ **->`experiment.js`** - defines the main experiment (trial structure, input data etc.)
	+ `main.js`       - main functionality to run experiment; usually user will not edit this
    + `helpers.js`    - helper functions specific to each particular experiment; user might edit this
	+ `submit_to_server.js` - functions to process, send or store data; user will almost never edit this
+ `images`       - images shown in this experiment (optional)
+ **->`trial_info/`**
	+ `trials.js` - external information for main trials
	+ `practiceTrials.js` - external information for practice trials
+ `styles/styles.css`  - style files
+ `libraries`    - external libraries

This file structure is only a suggestion. Whatever you choose to use, make sure to load everything of relevance in `index.html`, e.g., like so:

```html
<!-- config -->
<script src="config/config_deploy.js"></script>

<!-- local js files -->
<script src="scripts/main.js"></script>
<script src="scripts/experiment.js"></script>
<script src="scripts/helpers.js"></script>
<script src="scripts/submit_to_server.js"></script>

<!-- local trial_info files -->
<script src="trial_info/main_trials.js"></script>
<script src="trial_info/practice_trials.js"></script>

<!-- views -->
<script src="views/views.js"></script>
```



## The `exp`-object

The main work behind the scenes takes place in the interaction between `scripts/experiment.js` and `scripts/main.js`. The latter shields off convenience functions from the user who does not wish to be bothered (such as rearranging data for submission, finding the next trial/view based on the user's specifications etc.). To customize an experiment, editing `scripts/experiment.js` is necessary, however.

What `script/experiment.js` contributes is the `customize()` function for the `exp`-object. The `exp`-object is the main object that contains all information about how to realize your experiment. It is created automatically in `scripts/main.js`. It collects the data and finally submits it (using function `exp.submit()`;see below). Think of it as an entity which reads information about your trials (e.g., stored in a separate file like `trial_info.js`), realizes an experimental structure as a sequence of **views** (see below), collects your data (in variables `trial_data` and `global_data`) and finally submits it.

<img src="../images/exp_schema.png" width="100%" >

There are only three required properties of the `exp`-object that the user will normally manipulate inside of the `exp.customize()` function. First, `exp.global_data` is an object which collects all data that is recorded only once. We will usually want to store some information experiment-initially (e.g., starting time, participant info etc.) in this variable. The code below, for instance, stores the experiment start time and the start date.

```javascript
// customize the experiment by specifying a view order and a trial structure
exp.customize = function() {

    // record current date and time in global_data
    this.global_data.startDate = Date();
    this.global_data.startTime = Date.now();
	
    // specify view order
    this.views_seq = [intro,
                     instructions,
                     practice,
                     beginMainExp,
                     main,
                     postTest,
                     thanks];

    // prepare information about trials (procedure)
    // randomize main trial order, but keep practice trial order fixed
    this.trial_info.main_trials = _.shuffle(main_trials)
    this.trial_info.practice_trials = practice_trials
	
};
```

Second, there is `exp.views_seq` which is just an array of names of views that are defined in `views/views.js`. Views regulate all visuals and functionality and will be discussed at length below. The order of views in the `exp.views_seq` array defines the basic structure of the experiment. You can have a single view occur several times in this sequence. Third, there is `exp.trial_info` which contains all the information necessary to realize particular views, usually your main trials, giving specific information about which items participants see when. We will look into `exp.trial_info`.

### Trial information & randomization

Trial information is supplied as an array of objects, for example as in `trial_info/main_trials.js`, the content of which is:

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

This file defines that there are two types of trials which differ in a number of relevant pieces of information, such as the URL to a picture which will be shown, a question asked and two answer alternatives. If your experiment contains several different types of trials, we recommend supplying their information in separate files, like this template does for practice trials and main trials. There is also the possibility to load trial information from a CSV file. This is documented here. (TO BE WRITTEN SOON.)

Normally, we would like to randomize trial order in some way or other. This is what happens inside of `exp.customize()`, where we have:

```javascript
this.trial_info.main_trials = _.shuffle(main_trials)
```

In this way, the main trials are presented in a random order each time the experiment is started anew. The function `_.shuffle()` takes an array as input and returns a shuffled copy of that array. This function comes from the [lodash](https://lodash.com/) library, which is loaded by default. [lodash](https://lodash.com/) provides a number of useful convenience functions.


## Views


<img src="../images/view_schema.png" width="100%" >

## Config

bla bla

## Canvas

TO BE INCLUDED SOON
