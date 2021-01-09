---
layout: serverapp
title: Installation on a Heroku server
section: serverapp
---

# {{ page.title }}

The _magpie server app can be hosted on any hosting service or your own server. We here describe the process for
installation on [Heroku](https://www.heroku.com/).

[Heroku](https://www.heroku.com/) makes it easy to deploy an web app without having to manually manage the infrastructure. It has a free starter tier, which should be sufficient for the purpose of running experiments. If Heroku doesn't satisfy your needs, you may take a look at [Gigalixir](https://www.gigalixir.com/), an alternative free hosting service built for Elixir. Or you may want to to deploy the app on your own server.

There is an [official guide](https://hexdocs.pm/phoenix/heroku.html) from Phoenix framework on deploying on Heroku. The deployment procedure is based on this guide, but differs in some places.

1. Ensure that you have [the Phoenix Framework installed](https://hexdocs.pm/phoenix/installation.html) and working. (However, if you just want to deploy this server and do no development work/change on it at all, you may skip this step.)

2. Ensure that you have a [Heroku account](https://signup.heroku.com/) already, and have the [Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli) installed and working on your computer.

3. Ensure you have [Git](https://git-scm.com/downloads) installed. Clone this git repo with `git clone https://github.com/magpie-ea/magpie-backend` or `git clone git@github.com:magpie-ea/magpie-backend.git`.

4. `cd` into the project directory just cloned from your Terminal (or cmd.exe on Windows).

5. Run `heroku create --buildpack "https://github.com/HashNuke/heroku-buildpack-elixir.git"`

6. Run `heroku buildpacks:add https://github.com/gjaldon/heroku-buildpack-phoenix-static.git`

   (N.B.: Although the command line output tells you to run `git push heroku master`, don't do it yet.)

7. Run `heroku buildpacks:add https://github.com/chrismcg/heroku-buildpack-elixir-mix-release`

7. You may want to change the application name instead of using the default name. In that case, run `heroku apps:rename newname`.

8. Run `heroku config:set HOST="[app_name].herokuapp.com"` where `[app_name]` is the app name (shown when you first ran `heroku create`, e.g. `mysterious-meadow-6277`, or the app name that you set at the previous step, e.g. `newname`).

9. Run

   ```sh
   heroku addons:create heroku-postgresql:hobby-dev
   heroku config:set POOL_SIZE=18 PORT=443
   ```

10. Run `mix deps.get` then `mix phx.gen.secret`. Then run `heroku config:set SECRET_KEY_BASE="OUTPUT"`, where `OUTPUT` should be the output of the `mix phx.gen.secret` step.

    Note: If you don't have Phoenix framework installed on your computer, you may choose to use some other random generator for this step, which essentially asks for a random 64-character secret. On Mac and Linux, you may run `openssl rand -base64 64`. Or you may use an online password generator [such as the one offered by LastPass](https://lastpass.com/generatepassword.php).

11. By default, the app is accessible without authentication. If you want to protect the app with basic auth, first run ``. Set the environment variables `AUTH_USERNAME` and `AUTH_PASSWORD` for authentication, either in the Heroku web interface or via the command line, i.e.

    ```sh
    heroku config:set AUTH_USERNAME="your_username" AUTH_PASSWORD="your_password"
    ```

12. Run `git push heroku master`. This will push the `master` branch of the repo to the git remote at Heroku, and deploy the app.

13. Run `heroku run "_build/prod/rel/magpie/bin/magpie eval 'Magpie.ReleaseTasks.db_migrate()'"` (Note the `'` in the command.)

14. Now, `heroku open` should open the frontpage of the app.
