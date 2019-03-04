---
layout: overview
title: Obtain
section: overview
---

# {{ page.title }}

## Quick start to program an experiment

Creating a browser-based experiment with _babe does not require installation of fancy software. You basically only need a recent browser and a text editor, as well as [npm](https://www.npmjs.com/get-npm). A good way to start is by downloading the the [departure point](https://github.com/babe-project/departure-point), and then modifying it into the desired shape. Here's how to do this, step-by-step.

### Obtaining the `departure point`

1. if you don't have it already, install npm by following these [instructions](https://www.npmjs.com/get-npm)
2. download or clone this github repository: [https://github.com/babe-project/departure-point](https://github.com/babe-project/departure-point)
   - e.g. type `git clone https://github.com/babe-project/departure-point.git`
3. change the folder name `departure-point` to whatever you like
   - let's say you call is `my-exp`, e.g. by typing `mv departure-point my-exp`
4. go to your folder `my-exp`, e.g., by typing `cd my-exp`
5. now type `npm install`; this will download the Javascript packages with the most current version of _babe
6. you can have a look at the example experiment by opening the file `index.html` now
7. you can now start editing to create your own experiment

### Changing the `departure point` to your own experiment

- you can find more general explanations of the elements relevant for setting up a _babe experiment [here](https://github.com/babe-project/babe-project#Usage)

- usually, you might just want to manipulate the following files:
	- `main.js` :: contains the experiment structure and general information about deployment
	- `views.js` :: defines the different kinds of tasks, or, more generally, anything users will engage with on the screen
    - `custom_views.js` :: (optional) contains custom definitions in case the _babe templates are not enough for your purposes
	- `trials.js` :: (optional) contains information to realize different trials of a task (e.g., names of pictures, test sentences, questionaire questions etc.)

## Obtaining the server app

If you want to use the _babe server app, either locally on your computer or on a server, you should follow the detailed [installation instructions in the docs](../serverapp/overview.html).
