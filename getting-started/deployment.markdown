---
layout: getting-started
title: Deployment
section: start
---

# {{ page.title }}

{% include toc.html %}

<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-refresh-toc -->
**Table of Contents**

- [{{ page.title }}](#-pagetitle-)
    - [Online](#online)
        - [Frontend](#frontend)
            - [Crowdsourcing (MTurk, Prolific) or direct link?](#crowdsourcing-mturk-prolific-or-direct-link)
        - [Backend](#backend)
    - [Local](#local)
        - [Frontend](#frontend-1)
        - [Backend](#backend-1)
            - [First-time installation (requires internet connection)](#first-time-installation-requires-internet-connection)
            - [Deployment](#deployment)
    - [Debug](#debug)

<!-- markdown-toc end -->


There are several ways in which experiments can be deployed.

## Online
### Frontend
By default, _babe relies on [Github Pages](https://pages.github.com/) to make experiments accessible online. However, you may choose to use any static website host, such as [BitBalloon](https://www.bitballoon.com/) or [Gitlab Pages](https://about.gitlab.com/features/pages/) or even your own server, since in essence the experiments are composed of plain HTML/JS/CSS files.

To deploy an experiment via Github Pages:
1. make sure that the experiment repo is already on Github, e.g. https://github.com/babe-project/MinimalTemplate
2. Go to "Settings" tab of the repo, e.g. https://github.com/babe-project/MinimalTemplate/settings
3. Scroll down to find the section titled "GitHub Pages". Under "Source", choose "master branch" and click on save.
4. The experiment should now be available at your-account.github.io/ExperimentName, e.g. https://babe-project.github.io/MinimalTemplate/

<!--- Make sure that the entry point of the experiment is named `index.html`. Otherwise Github Pages will not be able to serve the experiment correctly. -->

#### Crowdsourcing (MTurk, Prolific) or direct link?
You might post the experiment via [Amazon Mechanical Turk](https://www.mturk.com/), [Prolific](https://www.prolific.ac/), or by directly sending the link to the participants. Please change the `config/config_deploy.js` in the experiment directory accordingly, and then push the changes via git:

```javascript
var config_deploy = {
	...
	"deployMethod" : 'directLink', //  use one of 'MTurk', 'Prolific', 'directLink'
	...
}
```

### Backend
After an experiment is finished online, the results need to be stored and retrieved later. A server is needed for that purpose. The default server implementation for _babe is at https://github.com/babe-project/ProComPrag. It is based on [Phoenix Framework](http://phoenixframework.org/) and written in [Elixir](https://elixir-lang.org/). It is deployed on Heroku at https://procomprag.herokuapp.com/.

Experiment results are submitted with [HTTP POST](https://en.wikipedia.org/wiki/HTTP_POST) in [JSON format](https://en.wikipedia.org/wiki/JSON).

The server provides an user interface to retrieve the experiment results in CSV format. You'll need to enter the `experiment-id` and `author` values that you specified in the `config/config_deploy.js` file.

Although you can use the default deployment on Heroku, you are recommended to deploy your own server instance, either with Heroku or with other hosting services you see fit. The detailed deployment instructions for Heroku can be found [here](https://babe-project.github.io/babe_site/docs/deployment.html#online-server-deployment-instructions-with-heroku)

Remember to change the submission URL in `scripts/submit_to_server.js` if you use your own server.

## Local
Sometimes you may want to let the participants complete an experiment directly on a local machine without requiring internet connection. This is particularly useful for doing fieldwork or working in labs.

### Frontend
The only change needed should be in `config/config_deploy.js`

```javascript
var config_deploy = {
	...
	"deployMethod" : 'localServer',
	...
}
```

You can then run the experiment by opening `index.html` in the browser in your local machine, and invite participants to finish the experiment.

(Of course, if the machine on which the experiment is run has internet connection, you can still specify `directLink` as the `deployMethod`, and the results will be submitted to the online server instead. This way you won't need to additionally run a local server.)

### Backend
This time, the server needs to be deployed on the local machine instead of online. To simplify the deployment, [Docker](https://www.docker.com/) is used. Please refer to [the documentation](https://babe-project.github.io/babe_site/docs/deployment.html#local-server-deployment-instructions-with-docker) for detailed deployment instructions.

## Debug
With "Debug" deployment, no backend server will be used and no experiment results will be actually recorded. Instead, the results will be displayed directly on the webpage when the experiment is finished. This helps you debug the experiment and ensure that the experiment data is recorded as intended.

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
