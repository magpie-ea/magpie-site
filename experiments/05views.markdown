---
layout: experiments
title: Views
section: experiments
---

# {{ page.title }}

[::: THIS PAGE IS STILL UNDER CONSTRUCTION :::]

Views are the main building blocks of a _babe experiment. A view regulates what participants see on the screen and how they can respond to what they see. 

We distinguish *view types* and *view instances*. Your experiment will be a sequence of view instances. Each view instance is of exactly one view type. The view type regulates the basic look-and-behavior; the instance fills it with life (e.g., supplying the information in `trials.js`). 

There are two kinds of view types. *Template view types* are ready-made view types supplied by _babe. You can use instances of these if they fit your purpose well enough. Instances of template view types allow for moderate customization. *Custom view types* are view types that you define when the template view types do not provide what is relevant for you. 

The Departure Point uses a bunch of template views, but also defines one custom view. Template views are instantiated in the file `views.js` and the custom view type `multi_dropdown` is defined and instantiated in `custom_views.js`. They give you full control over layout and functionality, but also require more work.

## Template view types

_babe provides a number of ready-made template view types. They are accessible via the `babeViews` object. An overview is [here](https://github.com/babe-project/babe-project/blob/master/docs/views.md). For example, the Departure Point defines an instance of the template type `intro` in the file `views.js` like so:

```javascript
// defines a view instance of view template 'intro'
const intro = babeViews.intro({
    trials: 1,
    name: 'intro',
    text: 'This is a sample introduction view. (...).',
    buttonText: 'begin the experiment'
});

```

The constructor function `babeViews.intro()` supplies a view of the type 'intro'. It takes as an argument an object with some required and some optional fields (as described in detail  [here](https://github.com/babe-project/babe-project/blob/master/docs/views.md)). For example, the code above says that this view has one trial: it will be repeated only once before advancing to the next view in the sequence of views. We need to give each view a name, here 'intro', so that we can refer to it from inside the experiment. The fields `text` and `buttonText` can be used to customize the text displayed on the screen and on the button shown. 

The 'intro' view is an instance of a so-called *wrapping view*. Wrapping views do not collect data from consecutive trials. That's what *trial views* do. The Departure Point instantiates a template trial view type, namely `babeViews.forcedChoice`. Here is the relevant code from `views.js`:

```javascript
const task_one_2AFC = babeViews.forcedChoice({
    trials: part_one_trial_info.forced_choice.length,
    name: 'task_one',
    trial_type: '2A_forced_choice',
    data: part_one_trial_info.forced_choice
});
```

We call the constructor function and tell it about the view instance' `name` and `trial_type`. For all trial views, the field `trial_type` is obligatory, as it provides the name of the task as it will show up in the data output. We also supply data via the field `data`. Concretely, we feed the object called `part_one_trial_info.forced_choice` provided in `trials.js` into the view here. We also supply information about how many trials of this view type should be shown subsequently. We set the `trials` field here to the length of the trial data object. (The `trials` field can contain a smaller integer, but supplying a bigger integer will result in an error.)


## Custom view templates

Trial view types defined in _babe include `forcedChoice`, `sliderRating`, `textboxInput`, `ratingScale`, 
