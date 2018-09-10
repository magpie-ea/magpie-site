---
layout: experiments
title: File structure
section: experiments
---

# {{ page.title }}

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
	+ `main_trials.js` - external information for main trials
	+ `practice_trials.js` - external information for practice trials
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

