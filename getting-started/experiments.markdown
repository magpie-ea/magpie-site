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



## The `exp`-object

The main work behind the scenes takes place in the interaction between `scripts/experiment.js` and `scripts/main.js`. The latter shields off convenience functions from the user who does not wish to be bothered (such as rearranging data for submission, finding the next trial/view based on the user's specifications etc.). To customize an experiment, editing `scripts/experiment.js` is necessary, however.

What `script/experiment.js` contributes is the `customize()` function for the `exp`-object. The `exp`-object is the main object that contains all information about how to realize your experiment. It is created automatically in `scripts/main.js`. It collects the data and finally submits it (using function `exp.submit()`; see below). Think of it as an entity which reads information about your trials (e.g., stored in a separate file like `trial_info.js`), realizes an experimental structure as a sequence of **views** (see below), collects your data (in variables `trial_data` and `global_data`) and finally submits it.

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

Second, there is `exp.views_seq` which is just an array of names of views that are defined in `views/views.js`. Views regulate all visuals and functionality and will be discussed at length below. The order of views in the `exp.views_seq` array defines the basic structure of the experiment. You can have a single view occur several times in this sequence. Third, there is `exp.trial_info` which contains all the information necessary to realize particular views, usually your main trials, giving specific information about which items participants see when. We will look into `exp.trial_info` in more depth next.

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

Views correspond to the larger coherent chunks of the experiment, e.g., an instructions screen or blocks of practice or main trials. Conceptually, a view is a pair that consists of a view-template (defined in `index.html`) and a view-object (defined in `views/views.js`).

<img src="../images/view_schema.png" width="100%" >

The view-template in `index.html` essentially declares placeholders which are then filled by the corresponding view-object. Placeholders are declared and filled using [mustache](https://mustache.github.io/). Below is the view-template for the main experimental trials from the minimal template, which declares mustache-variables `picture`, `question`, `option1` and `option2`. These variables will be filled in a dynamic way with information by the corresponding view-object. (<strong>Notice:</strong> if you want to put HTML tags into a mustache variable you will need three curly braces around it, not just two (e.g., we HTML markup is rendered correctly when inserted into variable `question` but not when inserted in variable `picture` in the code below).)

```html
{% raw %}
<!-- main view (buttons response) -->
<script id="main-view" type="x-tmpl-mustache">
  <div class="view">
  <div class="progress-bar-container">
	<p>progress</p>
	<div class="progress-bar"><span id='filled'><span></div>
  </div>
  <div class="clearfix"></div>
  <div class="picture", align = "center">
    <img src={{picture}} alt="a picture" height="100" width="100">
  </div>

  <p class="question">
    {{# question }}
	  {{{ question }}}
    {{/ question }} 
  </p>

  <p class="answer-container">
	<label for="yes" class="button-answer">{{ option1 }}</label>
	<input type="radio" name="answer" id="yes" value={{ option1 }} />
	<input type="radio" name="answer" id="no" value={{ option2 }} />
	<label for="no" class="button-answer">{{option2}}</label>
  </p>

  </div>
</script>
{% endraw %}
```

A view-object has two mandatory elements. First, `trials` contains the number of trials with which a view should be repeated. Second, it must contain a `render()` function which, most importantly, fills the mustache variables with content. The `render()` function could also, if relevant, record data or define input dependent reactions. The view-object of the main view in the minimal template (shown below) does record data, for example by storing it in `exp.trial_data` upon a button click. It also fills the relevant mustache-variables with information from `exp.trial_info`, updates a progress bar and records the starting time of the trial (so that it can calculate reaction times). Finally, the `render()` function receives information about the current trial `CT`, so that it can use this information to retrieve the relevant trial information from `exp.trial_info`.

```javascript
var main = {
    
    trials : 2,
    
    render : function(CT) {
        
        // fill variables in view-template
        var viewTemplate = $('#main-view').html();
        $('#main').html(Mustache.render(viewTemplate, {
            question: exp.trial_info.main_trials[CT].question,
            option1:  exp.trial_info.main_trials[CT].option1,
            option2:  exp.trial_info.main_trials[CT].option2,
            picture:  exp.trial_info.main_trials[CT].picture
        }));
        
        // update the progress bar
        var filled = CT * (180 / exp.views_seq[exp.currentViewCounter].trials);
        $('#filled').css('width', filled);

        // event listener for buttons; when an input is selected, the response
        // and additional information are stored in exp.trial_info
        $('input[name=answer]').on('change', function() {
            RT = Date.now() - startingTime; // measure RT before anything else
            trial_data = {
                trial_type: "mainForcedChoice",
                trial_number: CT+1,
                question: exp.trial_info.main_trials[CT].question,
                option1:  exp.trial_info.main_trials[CT].option1,
                option2:  exp.trial_info.main_trials[CT].option2,
                option_chosen: $('input[name=answer]:checked').val(),
                RT: RT
            };
            exp.trial_data.push(trial_data);
            exp.findNextView();
        });
        
        // record trial starting time
        startingTime = Date.now();
        
    }
};
```

## Config

The user is free to add global config information in a file like `config/config_general.js`. Some templates do (like the SRP template (documentation pending)), but the minimal template does not. 

Every experiment needs information about **deployment**. Deployment is the way in which the experiment is realized and its collected data is processed. The user would normally only interact with the deployment configuration in file `config/config_deployment.js` by choosing one of the specified options as a string value for `deploymentMethod`, see code below: 

```javascript
var config_deploy = {
    
    // obligatory fields
	
    // needed to recover data from server app
    "author": "RandomJane",
    // needed to recover data from server app
    "experiment_id": "MinimalTemplateDEMO", 
    "description": "A minimal template for a browser-based experiment",

    // set deployment method; use one of:
    //'debug', 'localServer', 'MTurk', 
    // 'MTurkSandbox', 'Prolific', 'directLink'
    "deployMethod" : "debug", 
    
    // optional fields
    
    // who to contact in case of trouble
    "contact_email": "YOUREMAIL@wherelifeisgreat.you", 
};
```

For the minimal template, we will only use the `debug` deployment method, which shows the final data as a table on the screen. This is the format in which you would get your data as a `*.csv` file if you would submit your data to a, say, crowd-sourcing platform or the _babe server app. How to do this is introduced in the [next section on deployment methods](deployment.html) and elaborated on in the [docs](../docs/) (TO BE ADDED SOON).

## Dynamic retrieval of previous experiment results
For some experiments, it might helpful to fetch and use data collected from previous experiment submissions in order to dynamically generate future trials. The _babe backend now provides this functionality.

For each experiment, you can specify the keys that should be fetched in the "Edit Experiment" user interface on the server app. Then, with a HTTP GET call to the `retrieve_experiment` endpoint, specifying the experiment ID, you will be able to get a JSON object that contains the results of that experiment so far.

`{SERVER_ADDRESS}/api/retrieve_experiment/:id`

A [minimal example](https://jsfiddle.net/SZJX/dp8ewnfx/) of frontend code using jQuery:

```javascript
  $.ajax({
    type: 'GET',
    url: "https://babe-demo.herokuapp.com/api/retrieve_experiment/1",
    crossDomain: true,
    success: function (responseData, textStatus, jqXHR) {
    	console.table(responseData);
    }
  });
```
