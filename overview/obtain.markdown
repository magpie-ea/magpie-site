---
layout: overview
title: Obtain
section: overview
---

# {{ page.title }}

## Quick start to program an experiment

Creating a browser-based experiment with _magpie does not require installation of fancy software. You basically only need a recent browser and a text editor, as well as [npm](https://www.npmjs.com/get-npm). A good way to start is by downloading the [departure point](https://github.com/magpie-ea/magpie-departure-point), and then modifying it into the desired shape. Here's how to do this, step-by-step.

### Obtaining the `departure point`

1. if you don't have it already, install npm by following these [instructions](https://www.npmjs.com/get-npm)
2. download or clone this GitHub repository: [https://github.com/magpie-ea/magpie-departure-point](https://github.com/magpie-ea/magpie-departure-point)
   - e.g. type `git clone https://github.com/magpie-ea/magpie-departure-point.git`
3. change the folder name `magpie-departure-point` to whatever you like
   - let's say you call it `my-exp`, e.g. by typing `mv magpie-departure-point my-exp`
4. go to your folder `my-exp`, e.g., by typing `cd my-exp`
5. now type `npm install`; this will download the JavaScript packages with the most current version of _magpie
6. you can have a look at the example experiment by opening the file `index.html` now
7. you can now start editing to create your own experiment

### Changing the `departure point` to your own experiment

- Usually, you might just want to manipulate the following files:
	- `01_custom_functions.js` :: (optional) contains custom functions, variables and hooks (e.g. a global coin flip)
	- `02_custom_views_templates.js` :: (optional) contains user-defined special-purpose view templates (only needed, if the provided view templates are not enough for your experiment)
	- `03_trials.js` :: (optional) contains the data of different trials of a task (e.g., names of pictures, test sentences, questions, etc.)
	- `04_views.js` :: defines the different kinds of tasks, or, more generally, anything users will engage with on the screen
	- `05_main.js` :: contains the experiment structure and general information about deployment
- The numbering of the files is important, you can use the functions defined in `01` in `04`, but you can't use some variable from `05` in `02`

## Obtaining the server app

If you want to use the _magpie server app, either locally on your computer or on a server, you should follow the detailed [installation instructions in the docs](../serverapp/overview.html).
