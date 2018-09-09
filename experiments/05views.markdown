---
layout: experiments
title: Views
section: experiments
---

# {{ page.title }}

Views correspond to the larger coherent chunks of the experiment, e.g., an instructions screen or blocks of practice or main trials. Conceptually, a view is a pair that consists of a view-template (defined in `index.html`) and a view-object (defined in `views/views.js`).

<img src="../images/view_schema.png" width="100%" >

The view-template in `index.html` essentially declares placeholders which are then filled by the corresponding view-object. Placeholders are declared and filled using [mustache](https://mustache.github.io/). Below is the view-template for the main experimental trials from the minimal template, which declares mustache-variables `picture`, `question`, `option1` and `option2`. These variables will be filled in a dynamic way with information by the corresponding view-object. (<strong>Notice:</strong> if you want to put HTML tags into a mustache variable you will need three curly braces around it, not just two (e.g., HTML markup is rendered correctly when inserted into variable `question` but not when inserted in variable `picture` in the code below).)

```html
{% raw %}
<!-- main view (buttons response) -->
<script id="main-view" type="x-tmpl-mustache">
<div class="view">

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
// render function renders the view
render: function (CT) {
  // fill variables in view-template
  var viewTemplate = $('#main-view').html();
  $('#main').html(Mustache.render(viewTemplate, {
    question: exp.trial_info.main_trials[CT].question,
    option1: exp.trial_info.main_trials[CT].option1,
    option2: exp.trial_info.main_trials[CT].option2,
    picture: exp.trial_info.main_trials[CT].picture}
  ));
  
  // event listener for buttons; when input is selected, response
  // and additional information are stored in exp.trial_info
  $('input[name=answer]').on('change', function () {
    RT = Date.now() - startingTime; // measure RT first
    trial_data = {
    trial_type: "mainForcedChoice",
    trial_number: CT + 1,
    question: exp.trial_info.main_trials[CT].question,
    option1: exp.trial_info.main_trials[CT].option1,
    option2: exp.trial_info.main_trials[CT].option2,
    option_chosen: $('input[name=answer]:checked').val(),
    RT: RT
    };
  exp.trial_data.push(trial_data);
  exp.findNextView();
  });

  // record trial starting time
  startingTime = Date.now();

},
trials: 4
};
```
