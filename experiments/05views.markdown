---
layout: experiments
title: Views
section: experiments
---

# {{ page.title }}

Views are the main building blocks of a _magpie experiment. A view regulates what participants see on the screen and how they can respond to what they see.

We distinguish *view types* and *view instances*. Your experiment will be a sequence of view instances. Each view instance is of exactly one view type. The view type regulates the basic look-and-behavior; the instance fills it with life (e.g., supplying the information in `04_trials.js`).

There are two kinds of view types. *Template view types* are ready-made view types supplied by _magpie. You can use instances of these if they fit your purpose well enough. Instances of template view types allow for moderate customization. *Custom view types* are view types that you define when the template view types do not provide what is relevant for you.

The Departure Point uses a bunch of template views, but no customization (see the [documentation](https://magpie-ea.github.io/magpie-docs/) for examples of customized template views and fully customized views). All views are instantiated in the file `05_views.js`.

## Template view types

_magpie provides a number of ready-made template view types. They are accessible via the `magpieViews` object and the `view_generator` function. An overview of available templates is in the  [documentation](https://magpie-ea.github.io/magpie-docs/). For example, the Departure Point defines an instance of the template type `intro` in the file `05_views.js` like so:

```javascript
// defines a view instance of view template 'intro'
const intro = magpieViews.view_generator("intro",{
    trials: 1,
    name: 'intro',
    text: 'This is a sample introduction view. (...).',
    buttonText: 'begin the experiment'
});
```

The constructor function `magpieViews.intro()` supplies a view of the type 'intro'. It takes as an argument an object with some required and some optional fields (as described in detail in the [documentation](https://magpie-ea.github.io/magpie-docs/)). For example, the code above says that this view has one trial: it will be repeated only once before advancing to the next view in the sequence of views. We need to give each view a name, here 'intro', so that we can refer to it from inside the experiment. The fields `text` and `buttonText` can be used to customize the text displayed on the screen and on the button shown.

The 'intro' view is an instance of a so-called *wrapping view*. Wrapping views do not collect data from consecutive trials. That's what *trial views* do. The Departure Point instantiates a template trial view type, namely `magpieViews.forcedChoice`. Here is the relevant code from `05_views.js`:

```javascript
const forced_choice_2A = magpieViews.view_generator("forced_choice", {
    trials: trial_info.forced_choice.length,
    name: 'forced_choice_2A',
    data: trial_info.forced_choice
});
```

We call the constructor function and tell it about the view instance' `name`, which provides the name of the task as it will show up in the data output and is used to internally identify this view (e.g., for use with a progress bar). We also supply data via the field `data`. Concretely, we feed the object called `trial_info.forced_choice` provided in `04_trials.js` into the view here. We also supply information about how many trials of this view type should be shown subsequently. We set the `trials` field here to the length of the trial data object. (The `trials` field can contain a smaller integer, but supplying a bigger integer will result in an error.)


<!-- ## Custom view templates -->

<!-- Trial view types defined in _magpie include stuff like `forcedChoice`, `sliderRating`, `textboxInput`, or `ratingScale`. (See [here](https://github.com/magpie-ea/magpie-modules/blob/master/docs/views.md) for overview.) It may happen, however, that these templates are not enough for your purposes. For example, the template `dropdownChoice` realizes a view with one drop-down menu for selection. If you need more than one, you can define your own custom view type. The Departure Point defines a custom view type called `multi_dropdown` in file `custom_views.js`.  -->
