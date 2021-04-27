---
layout: experiments
title: The `_magpie`-object & `05_main.js`
section: experiments
---

# {{ page.title }}

At the heart of a _magpie experiment is a JavaScript object called `_magpie`. In practice you will usually not interact with this object directly. It is like the theater in which the play is staged; you will normally engage with the actors and the stage but not with the theater itself.

The `_magpie`-object is created in the file `06_main.js` by a function called `magpieInit()`, which is called automatically when the site has completed loading. The content of your `06_main.js`-file therefore looks like this:

```javascript
// initializes a magpie experiment with magpieInit
$("document").ready(function() {

    // calls magpieInit
    magpieInit( ... your_magpieInit_config_object ... );

});

```

The argument to be passed to `magpieInit` is an object which lets you specify the structure of the experiment and its most important properties, such as what to do with the data collected during an execution (save it to a database, show it on the screen for debugging etc.). To understand this object, it helps to know a bit more about the `_magpie`-object itself.

The main job of the `_magpie`-object is to realize a sequence of so-called *views*, i.e., parts of the experiment like the introduction, instructions or individual trials, into the right sequence. It makes information about how individual trials are to be realized, i.e., what picture to show or which condition to show, which you supply in file `04_trials.js` and makes it available to each view. It then collects the data from the execution of the experiment and processes it in the desired way. Schematically, this would look like this:  

<img src="../images/magpie_object.png" width="100%" >

In sum, think of a `_magpie`-object as an entity that reads information about your trials (e.g., stored in a separate file like `04_trials.js`), realizes an experimental structure as a sequence of **views** (see below), collects your data (in variables `trial_data` and `global_data`) and finally submits it.

When you initialize an experiment with `magpieInit` you need to specify a sequence of views and the *deployment method*. For example, the call to `magpieInit` in the [Departure Point](https://github.com/magpie-ea/magpie-departure-point) looks as follows:


```javascript
magpieInit({
    // which views to realize in which sequence
    views_seq: [
        intro,
        instructions,
        forced_choice_2A,
        post_test,
        thanks,
    ],
    // what to do with the collected data
    deploy: {
        experimentID: "INSERT_A_NUMBER",
        serverAppURL: "SOME-URL",
        deployMethod: "debug",
        contact_email: "YOUREMAIL@wherelifeisgreat.you",
        prolificURL: "SOME-URL"
    }
}
```

The next three sections will look at the structure of the `04_trials.js`-file, the views and the deployment method in more detail.
