---
layout: experiments
title: The `_babe`-object & `main.js`
section: experiments
---

# {{ page.title }}

huhu At the heart of a _babe experiment is a Javascript object called `_babe`. In practice you will usually not interact with this object directly. It is like the theater in which the play is staged; you will normally engage with the actors and the stage but not with the theater itself.

The `_babe`-object is created in the file `main.js` by a function called `babeInit()`, which is called automatically when the site has completed loading. The content of your `main.js`-file therefore looks like this:

```javascript
// initialises a babe experiment with babeInit
$("document").ready(function() {

    // calls babeInit
    babeInit( ... your_babeInit_config_object ... );
    
});

```

The argument to be passed to `babeInit` is an object which lets you specify the structure of the experiment and its most important properties, such as what to do with the data collected during an execution (save it to a data base, show it on the screen for debugging etc.). To understand this object, it helps to know a bit more about the `_babe`-object itself.

The main job of the `_babe`-object is to realize a sequence of so-called *views*, i.e., parts of the experiment like the introduction, instructions or individual trials, into the right sequence. It makes information about how individual trials are to be realized, i.e., what picture to show or which condition to show, which you supply in file `trials.js` and makes it available to each view. It then collects the data from the execution of the experiment and processes it in the desired way. Schematically, this would look like this:  

<img src="../images/babe_object.png" width="100%" >

In sum, think of a `_babe`-object as an entity which reads information about your trials (e.g., stored in a separate file like `trial_info.js`), realizes an experimental structure as a sequence of **views** (see below), collects your data (in variables `trial_data` and `global_data`) and finally submits it.

When you initialize an experiment with `babeInit` you need to specify a sequence of views and the *deployment method*. For example, the call to `babeInit` in the [Departure Point](https://github.com/babe-project/departure-point) looks as follows:


```javascript
babeInit({
    // which views to realize in which sequence
    views_seq: [
        intro,
        instructions,
        task_one_2AFC,
        task_two_sentence_completion,
        instructionsPostTest,
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

The next three section will look at the structure of the `trials.js`-file, the views and the deployment method in more detail. 
