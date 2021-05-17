---
layout: experiments
title:  Understanding counters
section: experiments
---

# {{ page.title }}

The sequence of views for an experiment is specified by the user in `exp.customize()`. The number of trials in each view are specified by the key `trials` of that view-object. On top of this, the user can specify loops of sequences (see below). To realize this, _magpie uses a system of counters. It is good to understand the counter system for more advanced applications.

When a trial is finished, _magpie calls the function `exp.findNextView()`, which is defined in `main.js`, to decide what to show next in the sequence of views and trials. To do this, the `exp`-object has a property `exp.currentView` which just points to the current view-object. The `exp`-object also has two important counters, namely:

+ `exp.currentTrialCounter`: counts how many trials have passed during the whole experiment in total

+ `exp.currentTrialInViewCounter`: counts how many trials of the current view have passed already during the current block in which this view is shown repeatedly

Finally, there is also information about how many times a view has been shown already during the whole experiment. (A view can appear several times during an experiment, e.g., by using loops.) This information is not stored in the `exp`-object directly, but distributed as a property `CT` to each respective view. So, if we are interested in the number of times the current view has already occurred in the experiment so far in total, we find this number in `exp.views_seq[exp.currentViewCounter].CT`.
