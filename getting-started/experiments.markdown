---
layout: getting-started
title: Experiments
section: start
---

# {{ page.title }}

This guide walks through the minimal template, which you can [obtain here](../obtain.html), so that you can use it as a starting point of your own experiments. A full and extensive documentation is in the [docs](../docs/experiments.html).

{% include toc.html %}



## File structure

The minimal template contains the following files, of which the ones marked in bold are most important for everyday use:

+ **`index.html`** - starting point; loads all relevant files; provides view-templates;
+ **`config/config_deploy.js`/**  - information about how to deploy (=run, collect data for) the experiment
+ **`views/views.js`** - provides the view-objects; main work happens here
+ `scripts/`
	+ **`experiment.js`** - defines the main experiment (trial structure, input data etc.)
	+ `main.js`       - main functionality to run experiment; usually user will not edit this
    + `helpers.js`    - helper functions specific to each particular experiment; user might edit this
	+ `submit_to_server.js` - functions to process, send or store data; user will almost never edit this
+ `images`       - images shown in this experiment (optional)
+ `trial_info/`
	+ `trials.js` - external information for main trials
	+ `practiceTrials.js` - external information for practice trials
+ `styles/styles.css`  - style files
+ `libraries`    - external libraries

This file structure is only a suggestion. Make sure to load everything of relevance in `index.html`, e.g., like so:

```html
<!-- config -->
<script src="config/config_deploy.js"></script>

<!-- local js files -->
<script src="scripts/main.js"></script>
<script src="scripts/experiment.js"></script>
<script src="scripts/helpers.js"></script>
<script src="scripts/submit_to_server.js"></script>

<!-- local trial_info files -->
<script src="trial_info/trials.js"></script>
<script src="trial_info/practiceTrials.js"></script>

<!-- views -->
<script src="views/views.js"></script>
```



## The `exp`-object

The main work behind the scenes takes place in the interaction between `scripts/experiment.js` and `scripts/main.js`. The latter shields off convenience functions from the user who does not wish to be bothered (such as rearranging data for submission, finding the next trial/view based on the user's specifications etc.). To customize an experiment, editing `scripts/experiment.js` is necessary, however.

What `script/experiment.js` contributes is the `init()` (initialization) function for the `exp`-object. The `exp`-object is the main object that contains all information about how to realize your experiment. It collects the data and finally submits it (using function `exp.submit()` which is called in the `thanks`-view; see below). Think of it as an entity which reads information about your trials (e.g., stored in a separate file like `trial_info.js`), realizes an experimental structure as a sequence of **views** (see below), collects your data (in variables `trial_data` and `global_data`) and finally submits it.

<img src="../images/exp_schema.png" width="100%" >

There are only three required properties of the `exp`-object that the user will have to manipulate inside of the `exp.init()` function in file `experiment.js`. First, `exp.global_data` is an object which collects all data that is recorded only once. You will usually want to store some information experiment-initially (e.g., starting time, participant info etc.) in this variable. The code below, for instance, stores the experiment start time and the start date.

```javascript
// initialize the experiment
exp.init = function() {

    // allocate storage room for global and trial data
    this.global_data = {};
    this.trial_data = [];

    // record current date and time
    this.global_data.startDate = Date();
    this.global_data.startTime = Date.now();

    // specify view order
    this.views = [intro,
                  instructionsForcedChoice,
                  practiceForcedChoice,
                  beginForcedChoice,
                  mainForcedChoice,
                  instructionsSliderRating,
                  mainSliderRating,
                  postTest,
                  thanks];
				  
    // initialize counter structure (normally you do not change this)
    this.initializeProcedure();

    // prepare information about trials (procedure)
    this.trial_info = prepareData();
	
};
```

Second, there is `exp.views` which is just an array of names of views that are defined in `views/views.js`. Views regulate all visuals and functionality and we will discuss them at length below. The order of views in the `exp.views` array defines the basic structure of the experiment. You can have a single view occur several times in this sequence. Third, there is `exp.trial_info` which contains all the information necessary to realize particular views, usually your main trials, giving specific information about which items participants see when. We will look into `exp.trial_info` presently.

There are two more ingredients in the code above. `exp.trial_data` is just initialized here. It will later collect all data that is recorded repeatedly in different trials (e.g., responses, reaction times, etc.). The function `exp.initializeProcedure()` provides basic functionality and need usually not be tinkered with.

### `exp.trial_info`

- how to load data
- how to randomize



## Views



<img src="../images/view_schema.png" width="100%" >

## Config

bla bla

## Canvas

bla bla bla
