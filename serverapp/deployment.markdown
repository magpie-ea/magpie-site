---
layout: serverapp
title: Deployment
section: serverapp
---

# {{ page.title }}

This page contains detailed deployment instructions.

## Online server deployment instructions with Heroku
[Heroku](https://www.heroku.com/) makes it easy to deploy an web app without having to manually manage the infrastructure. It has a free starter tier, which should be sufficient for the purpose of running experiments.

There is an [official guide](https://hexdocs.pm/phoenix/heroku.html) from Phoenix framework on deploying on Heroku. The deployment procedure is based on this guide, but differs in some places.

0. Ensure that you have [the Phoenix Framework installed](https://hexdocs.pm/phoenix/installation.html) and working. However, if you just want to deploy this server and do no development work/change on it at all, you may skip this step.

1. Ensure that you have a [Heroku account](https://signup.heroku.com/) already, and have the [Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli) installed and working on your computer.

2. Ensure you have [Git](https://git-scm.com/downloads) installed. Clone this git repo with `git clone https://github.com/babe-project/BABE` or `git clone git@github.com:babe-project/BABE.git`.

3. `cd` into the project directory just cloned from your Terminal (or cmd.exe on Windows).

4. Run `heroku create --buildpack "https://github.com/HashNuke/heroku-buildpack-elixir.git"`

5. Run `heroku buildpacks:add https://github.com/gjaldon/heroku-buildpack-phoenix-static.git`

  (N.B.: Although the command line output tells you to run `git push heroku master`, don't do it yet.)

6. You may want to change the application name instead of using the default name. In that case, run `heroku apps:rename newname`.

7. Edit line 17 of the file `config/prod.exs`. Replace the part `babe-backend.herokuapp.com` after `host` with the app name (shown when you first ran `heroku create`, e.g. `mysterious-meadow-6277.herokuapp.com`, or the app name that you set at step 6, e.g.  `newname.herokuapp.com`). You shouldn't need to modify anything else.

8. Ensure that you're at the top-level project directory. Run

  ```
  heroku addons:create heroku-postgresql:hobby-dev
  heroku config:set POOL_SIZE=18
  ```

9. Run `mix deps.get` then `mix phx.gen.secret`. Then run `heroku config:set SECRET_KEY_BASE="OUTPUT"`, where `OUTPUT` should be the output of the `mix phx.gen.secret` step.

  Note: If you don't have Phoenix framework installed on your computer, you may choose to use some other random generator for this task, which essentially asks for a random 64-character secret. On Mac and Linux, you may run `openssl rand -base64 64`. Or you may use an online password generator [such as the one offered by LastPass](https://lastpass.com/generatepassword.php).

10. Run `git add config/prod.exs`, then `git commit -m "Set app URL"`.

11. Don't forget to set the environment variables `AUTH_USERNAME` and `AUTH_PASSWORD`, either in the Heroku web interface or via the command line, i.e.

  ```
  heroku config:set AUTH_USERNAME="your_username"
  heroku config:set AUTH_PASSWORD="your_password"
  ```

12. Run `git push heroku master`. This will push the repo to the git remote at Heroku (instead of the original remote at Github), and deploy the app.

13. Run `heroku run "POOL_SIZE=2 mix ecto.migrate"`

14. Now, `heroku open` should open the frontpage of the app.

## Local server deployment instructions with Docker

### First-time installation (requires internet connection)

The following steps require an internet connection. After they are finished, the server can be launched offline.

1. Install Docker from https://docs.docker.com/install/. You may have to launch the application once in order to let it install its command line tools. Ensure that it's running by typing `docker version` in a terminal (e.g., the Terminal app on MacOS or cmd.exe on Windows).

  Note:
  - Although the Docker app on Windows and Mac asks for login credentials to Docker Hub, they are not needed for local deployment . You can proceed without creating any Docker account/logging in.
  - Linux users would need to install `docker-compose` separately. See relevant instructions at https://docs.docker.com/compose/install/.

2. Ensure you have [Git](https://git-scm.com/downloads) installed. Clone the server repo with `git clone https://github.com/babe-project/BABE.git` or `git clone git@github.com:babe-project/BABE.git`.

3. Open a terminal (e.g., the Terminal app on MacOS or cmd.exe on Windows), `cd` into the project directory just cloned via git.

4. For the first-time setup, run in the terminal
  ```
  docker volume create --name babe-app-volume -d local
  docker volume create --name babe-db-volume -d local
  docker-compose run --rm web bash -c "mix deps.get && npm install && node node_modules/brunch/bin/brunch build && mix ecto.migrate"
  ```

### Deployment

After first-time installation, you can launch a local server instance which sets up the experiment in your browser and stores the results.

1. Run `docker-compose up` to launch the application every time you want to run the server. Wait until the line `web_1  | [info] Running BABE.Endpoint with Cowboy using http://0.0.0.0:4000` appears in the terminal.

2. Visit `localhost:4000` in your browser. You should see the server up and running.

  Note: Windows 7 users who installed *Docker Machine* might need to find out the IP address used by `docker-machine` instead of `localhost`. See [Docker documentation](https://docs.docker.com/get-started/part2/#build-the-app) for details.

3. Use <kbd>Ctrl + C</kbd> to shut down the server.

Note that the database for storing experiment results is stored at `/var/lib/docker/volumes/babe-db-volume/_data` folder by default. As long as this folder is preserved, experiment results should persist as well.

