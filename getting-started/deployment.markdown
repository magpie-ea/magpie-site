---
layout: getting-started
title: Deployment
section: start
---

# {{ page.title }}

{% include toc.html %}

There are several ways in which experiments can be deployed.

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

## Online
### Frontend
By default, _babe relies on [Github Pages](https://pages.github.com/) to make experiments accessible online. However, you may choose to use any static website host, such as [BitBalloon](https://www.bitballoon.com/) or [Gitlab Pages](https://about.gitlab.com/features/pages/) or even your own server, since in essence the experiments are composed of plain HTML/JS/CSS files.

To deploy an experiment via Github Pages:
1. make sure that the experiment repo is already on Github, e.g. https://github.com/b-a-b-e/MinimalTemplate
2. Go to "Settings" tab of the repo, e.g. https://github.com/b-a-b-e/MinimalTemplate/settings
3. Scroll down to find the section titled "GitHub Pages". Under "Source", choose "master branch" and click on save.
4. The experiment should now be available at your-account.github.io/ExperimentName, e.g. https://b-a-b-e.github.io/MinimalTemplate/

<!--- Make sure that the entry point of the experiment is named `index.html`. Otherwise Github Pages will not be able to serve the experiment correctly. -->

You might post the experiment via [Amazon Mechanical Turk](https://www.mturk.com/), [Prolific](https://www.prolific.ac/), or by directly sending the link to the participants. Please change the `config/config_deploy.js` in the experiment directory accordingly:

```javascript
var config_deploy = {
	...
	"deployMethod" : 'directLink', //  use one of 'MTurk', 'Prolific', 'directLink'
	...
}
```

### Backend
After an experiment is finished online, the results need to be stored and retrieved later. A server is needed for that purpose. The default server implementation for _babe is at https://github.com/b-a-b-e/ProComPrag. It is based on [Phoenix Framework](http://phoenixframework.org/) and written in [Elixir](https://elixir-lang.org/). It is deployed on Heroku at https://procomprag.herokuapp.com/.

Experiment results are submitted with [HTTP POST](https://en.wikipedia.org/wiki/HTTP_POST) in [JSON format](https://en.wikipedia.org/wiki/JSON).

The server provides an user interface to retrieve the experiment results in CSV format. You'll need to enter the `experiment-id` and `author` values that you specified in the `config/config_deploy.js` file.

Although you can use the default deployment on Heroku, you are recommended to deploy your own server instance, either with Heroku or with other hosting services you see fit. The detailed deployment instructions for Heroku can be found at https://github.com/b-a-b-e/ProComPrag#deployment-with-heroku.

Remember to change the submission URL in `scripts/submit_to_server.js` if you use your own server.

## Local
Sometimes you may want to let the participants complete an experiment directly on a local machine which may not have internet connection. This is particularly useful for doing fieldwork or working in labs.

### Frontend
The only change needed should be in the `config/config_deploy.js`

```javascript
var config_deploy = {
	...
	"deployMethod" : 'localServer',
	...
}
```
### Backend
This time, the server needs to be deployed on the local machine instead of online. To simplify the deployment, [Docker](https://www.docker.com/) is used.

#### First-time installation (requires internet connection)

The following steps require an internet connection. After they are finished, the server can be launched offline.

1. Install Docker from https://docs.docker.com/install/. You may have to launch the application once in order to let it install its command line tools. Ensure that it's running by typing `docker version` in a terminal (e.g., the Terminal app on MacOS or cmd.exe on Windows).

  Note:
  - Although the Docker app on Windows and Mac asks for login credentials to Docker Hub, they are not needed for local deployment . You can proceed without creating any Docker account/logging in.
  - Linux users would need to install `docker-compose` separately. See relevant instructions at https://docs.docker.com/compose/install/.

2. Ensure you have [Git](https://git-scm.com/downloads) installed. Clone the server repo with `git clone https://github.com/b-a-b-e/ProComPrag.git` or `git clone git@github.com:ProComPrag/ProComPrag.git`.

3. Open a terminal (e.g., the Terminal app on MacOS or cmd.exe on Windows), `cd` into the project directory just cloned via git.

4. For the first-time setup, run in the terminal
  ```
  docker volume create --name procomprag-app-volume -d local
  docker volume create --name procomprag-db-volume -d local
  docker-compose run --rm web bash -c "mix deps.get && npm install && node node_modules/brunch/bin/brunch build && mix ecto.migrate"
  ```
#### Actual deployment

After first-time installation, you can launch a local server instance which sets up the experiment in your browser and stores the results.

1. Run `docker-compose up` to launch the application every time you want to run the server. Wait until the line `web_1  | [info] Running ProComPrag.Endpoint with Cowboy using http://0.0.0.0:4000` appears in the terminal.

2. Visit localhost:4000 in your browser. You should see the server up and running.

  Note: Windows 7 users who installed *Docker Machine* might need to find out the IP address used by `docker-machine` instead of `localhost`. See https://docs.docker.com/get-started/part2/#build-the-app for details.

Note that the database for storing experiment results is stored at `/var/lib/docker/volumes/procomprag-volume/_data` folder by default. As long as this folder is preserved, experiment results should persist as well.
