---
layout: experiments
title: File structure
section: experiments
---

# {{ page.title }}

The Departure Point contains the following files, of which the ones marked with **->** are most important for everyday use:

+ `index.html` : the file to open to start the experiment; contains the HTML placeholders to be filled with life by the other files; loads all relevant files; it is not usually necessary to open and manipulate this file;
+ **->`main.js`**  : basic control over the structure of the experiment (sequence of views); also holds information about how to deploy the experiment
+ **->`views.js`** : provides the view-objects which define what exactly the user sees on the screen; main work happens here
+ `custom_views.js` : in case _babe's ready-made views are not enough, you can define your own custom views here
+ `images` : folder with images shown (optional)
+ **->`trials.js`** : external information for main trials (e.g., which pictures or questions to show on each trial


