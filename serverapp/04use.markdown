---
layout: serverapp
title: Using the server app
section: serverapp
---

# {{ page.title }}

After installation you can visit the server app in a browser. (TODO: Specify how to retrieve
URL!) The server app shows a list of experiments for which data exists in the database. It
shows the experiments ID, its name, its author, the number of submissions retrieved so far,
date information, as well as whether the experiment is currently active or not. If an
experiment is set to be active, it allows further submissions to be recorded in its
database.

<img src="../images/server_app_screen.png" width="100%">

The server app allows you to retrieve the data for an experiment from its database. Simply
click on the button "retrieve CSV" to download a CSV-file with the data collected so far. 

To delete an experiment, click the "delete" button. Always make sure that you have recovered
all necessary data from that experiment; otherwise your data collected so far might be
irrevocably lost.

You can also edit an experiment with the "edit" button. You can change information about the
experiment on the edit-screen. You can also toggle whether the experiment is active or not. You
can set a maximum number of submissions after which the experiment automatically toggles its
activity status off. Any submission made by a participant to a non-active experiment is just
lost and will not be recorded. This is to protect your database from pollution or attacks, but
if used unwisely could also cause you loss of relevant data.




There are several ways in which experiments can be deployed.

{% include toc.html %}

## Deploying an experiment online

### Frontend configuration

By default, _babe relies on [Github Pages](https://pages.github.com/) to make experiments accessible online. However, you may choose to use any static website host, such as [Netlify](https://www.netlify.com/) or [Gitlab Pages](https://about.gitlab.com/features/pages/) or even your own server, since in essence the experiments are composed of plain HTML/JS/CSS files.

To deploy an experiment via Github Pages:
1. make sure that the experiment repo is already on Github, e.g. https://github.com/babe-project/MinimalTemplate
2. Go to "Settings" tab of the repo, e.g. https://github.com/babe-project/MinimalTemplate/settings
3. Scroll down to find the section titled "GitHub Pages". Under "Source", choose "master branch" and click on save.
4. The experiment should now be available at your-account.github.io/ExperimentName, e.g. https://babe-project.github.io/MinimalTemplate/

<!--- Make sure that the entry point of the experiment is named `index.html`. Otherwise Github Pages will not be able to serve the experiment correctly. -->

#### Crowdsourcing (MTurk, Prolific) or direct link?
You might recruit participants via [Amazon Mechanical Turk](https://www.mturk.com/), [Prolific](https://www.prolific.ac/), or by directly sending the link to them. Please change the `config/config_deploy.js` in the experiment directory accordingly, and then push the changes via git:

```javascript
var config_deploy = {
	...
	"deployMethod" : 'directLink', //  use one of 'MTurk', 'Prolific', 'directLink'
	...
}
```

### Backend configuration
After an experiment is finished online, the results need to be stored and retrieved later. A server is needed for that purpose. The default server implementation for _babe is available at https://github.com/babe-project/BABE. You may refer to its documentation for details. It is based on [Phoenix Framework](http://phoenixframework.org/) and written in [Elixir](https://elixir-lang.org/). A demo app is deployed on Heroku at https://babe-demo.herokuapp.com/.

In the current version of the server app, each experiment is explicitly created and managed with a user interface. After creation, each experiment gets assigned a unique ID. Experiment results need to be submitted with [HTTP POST](https://en.wikipedia.org/wiki/HTTP_POST) in [JSON format](https://en.wikipedia.org/wiki/JSON) to the endpoint displayed in the UI:

![Submission UI](../images/submission_ui.png)

Don't forget to set the unique ID in `config/config_deploy.js` of your frontend configuration:

```javascript
var config_deploy = {
	...
  "experiment_id": 1,
	...
}
```

You are recommended to deploy your own server instance, either with Heroku or with other hosting services you see fit. The detailed deployment instructions for Heroku can be found [here](https://babe-project.github.io/babe_site/docs/deployment.html#online-server-deployment-instructions-with-heroku)

## Deploying an experiment locally
Sometimes you may want to let the participants complete an experiment directly on a local machine without requiring internet connection. This is particularly useful for doing fieldwork or working in labs.

### Frontend configuration
The only change needed should be in `config/config_deploy.js`

```javascript
var config_deploy = {
	...
	"deployMethod" : 'localServer',
	...
}
```

You can then run the experiment by opening `index.html` in the browser in your local machine, and invite participants to finish the experiment.

(Of course, if the machine has internet connection, you can still specify `directLink` as the `deployMethod`, and the results will be submitted to the online server instead, even if the experiment is run locally. This way you won't need to additionally run a local server.)

### Backend configuration
This time, the server needs to be deployed on the local machine instead of online. To simplify the deployment, [Docker](https://www.docker.com/) is used. Please refer to [the documentation](https://babe-project.github.io/babe_site/docs/deployment.html#local-server-deployment-instructions-with-docker) for detailed deployment instructions.

Everything else, including the usage of the user interface, should remain the same just like in online deployment.

## Using the "debug" deployment
With "Debug" deployment, no backend server will be used and no experiment results will be actually recorded. Instead, the results will be displayed directly on the webpage when the experiment finishes. This helps you debug the experiment and ensure that the results are recorded as intended.

To set deployment mode to "Debug", simply set

```javascript
var config_deploy = {
	...
	"deployMethod" : 'debug',
	...
}
```

in the `config/config_deploy.js` file in your experiment directory.

You can then test the experiment by opening `index.html` in the browser in your local machine.

