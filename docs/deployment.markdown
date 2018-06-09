---
layout: docs
title: Deployment
section: docs
---

# {{ page.title }}

This page contains detailed deployment instructions.

{% include toc.html %}

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


## Posting a _babe experiment as a HIT on MTurk

You can post a _babe experiment as an external HIT on MTurk. If you are familiar with posting external HITs, the only thing that you need to take into account is that _babe experiments send their collected data to the _babe backend. So, in order to collect the data from your experiment, you would visit the _babe backend to download a CSV file. No need to go via MTurk.

If you are not familiar with posting external HITs on MTurk, here is an easy method to use that uses `boto3`, which is a Python SDK for Amazon's Web Services (AWS). The method is easy in the sense that it might require less downloading / installing than other methods. You only need Python and the `boto3` package. (But [here](https://github.com/Ciyang/experiment_template) and [there](https://cocolab.stanford.edu/mturk-tools.html) are fully viable alternative methods and resources that provide additional useful information.)

We assume that you have an MTurk account and that you have your AWS credentials ready at hand. (If not, see [here](https://github.com/Ciyang/experiment_template) for instructions on how to setup your account.) Download a recent version of Python (we used 3.6 at the time of writing) and install the `boto3` package, e.g., using `pip`. Next, in your homedirectory, create the file:

~~~
~./aws/config
~~~

Fill this file with the following content, so that `boto3` knows about your AWS credentials (never post this, host this or share this):

~~~

[default]
aws_access_key_id=YOUR_ACCESS_KEY_ID
aws_secret_access_key=YOUR_SECRET_ACCESS_KEY

~~~

Make sure that your _babe experiment is ready for MTurk deployment:

- set the deployment method in `config_deploy.js` to `MTurk` or `MTurkSandbox`
- host the experiment on a web server, e.g., using GitHub Pages
- make sure you have the URL for this page ready

Save the following code in a file called `post_HIT.py`, after inserting the correct URL to your experiment and commenting in/out the relevant lines depending on whether you want a real live experiment or a test version in the sandbox.

~~~python
import boto3

MTURK_SANDBOX = 'https://mturk-requester-sandbox.us-east-1.amazonaws.com'

mturk = boto3.client('mturk',
   region_name='us-east-1'
#   endpoint_url = MTURK_SANDBOX # include this for sandbox mode
)

your_url = "https://YOUR_URL" # insert your URL

external_question = """<ExternalQuestion xmlns='http://mechanicalturk.amazonaws.com/AWSMechanicalTurkDataSchemas/2006-07-14/ExternalQuestion.xsd'>
  <ExternalURL>""" + your_url + """</ExternalURL>
  <FrameHeight>600</FrameHeight>
</ExternalQuestion>"""

new_hit = mturk.create_hit(
    Title = 'Your title',
    Description = 'Your description',
    Keywords = 'some keywords',
    Reward = '0.5', # how much to pay
    MaxAssignments = 1, # how many participants
    LifetimeInSeconds = 172800, 
    AssignmentDurationInSeconds = 600,
    AutoApprovalDelayInSeconds = 14400,
    Question = external_question,
)

print("A new HIT has been created. You can preview it here:")
#print("https://workersandbox.mturk.com/mturk/preview?groupId=" + new_hit['HIT']['HITGroupId']) # comment in for sandbox mode
print("https://worker.mturk.com/mturk/preview?groupId=" + new_hit['HIT']['HITGroupId']) # use this otherwise
print("HITID = " + new_hit['HIT']['HITId'] + " (for your reference)")
~~~

Now execute `python postHIT.py`. You can manipulate (expire, extend, ...) your HIT using `boto3` as documented [here](http://boto3.readthedocs.io/en/latest/index.html). For some recurrent manipulations, you can also use [this web interface](https://manage-hits-individually.s3.amazonaws.com/v4.0/index.html).
