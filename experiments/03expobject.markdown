---
layout: experiments
title: The "exp" object
section: experiments
---

# {{ page.title }}

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

