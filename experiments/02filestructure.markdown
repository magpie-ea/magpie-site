---
layout: experiments
title: File structure
section: experiments
---

# {{ page.title }}

The Departure Point contains the following files, of which the ones marked with **->** are most important for everyday use. The numbering of the files indicates the order in which these files are loaded (so later loaded files can use ingredients defined in earlier files but not vice versa).

+ `index.html` : the file to open to start the experiment; contains the HTML placeholders to be filled with life by the other files; loads all relevant files; it is not usually necessary to open and manipulate this file;
+ `01_custom_styles.css` : customization of any CSS you might want to make
+ `02_custom_functions.js` : any helper functions you might want to have later on (also a good place to run any experiment-initial randomization)
+ `03_custom_views_templates.js` : define any custom views here if you need them
+ **->`04_trials.js`** : external information for main trials (e.g., which pictures or questions to show on each trial
+ **->`05_views.js`** : provides the view-objects which define what exactly the user sees on the screen; main work happens here
+ **->`06_main.js`**  : basic control over the structure of the experiment (sequence of views); also holds information about how to deploy the experiment
+ `images` : folder with images shown (optional)



