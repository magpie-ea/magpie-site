---
layout: datacollection
title: Posting a _babe experiment as a HIT on MTurk
redirect_from: /datacollection/1.html
section: datacollection
---

# {{ page.title }}

You can post a _babe experiment as an external HIT on MTurk. If you are familiar with posting external HITs, the only thing that you need to take into account is that _babe experiments send their collected data to the _babe backend. So, in order to collect the data from your experiment, you would visit the _babe backend to download a CSV file. No need to go via MTurk.

If you are not familiar with posting external HITs on MTurk, here is a simple method that uses `boto3`, which is a Python SDK for Amazon's Web Services (AWS). The [MTurkDeployTemplate](https://github.com/babe-project/MTurkDeployTemplate) gives a full example of an experiment that uses this method.

The method we propose here is easy in the sense that it might require less downloading / installing than other methods. You only need Python and the `boto3` package. (But [here](https://github.com/Ciyang/experiment_template) and [there](https://cocolab.stanford.edu/mturk-tools.html) are fully viable alternative methods and resources that provide additional useful information.)

We assume that you have an MTurk account and that you have your AWS credentials ready at hand. (If not, see [here](https://github.com/Ciyang/experiment_template) for instructions on how to setup your account.) Download a recent version of Python (we used 3.6 at the time of writing) and install the `boto3` package, e.g., using `pip`. Next, in your homedirectory, create the file:

~~~
~/.aws/config
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

Save the following code in a file called `create_HIT.py`, after inserting the correct URL to your experiment and commenting in/out the relevant lines depending on whether you want a real live experiment or a test version in the sandbox.

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

Now execute `python create_HIT.py`. Make sure you note the HITid that this call returns, because you need it to further identify this experimental run when interacting with MTurk. Download file `get_HIT_status.py` [here](https://github.com/babe-project/MTurkDeployTemplate/blob/master/get_HIT_status.py) and use `python get_HIT_status.py YOUR_HIT_ID`, where `YOUR_HIT_ID` is the HITid returned when you posted the HIT, to learn how many workers have completed your work. Download file `approve_HIT.py` [here](https://github.com/babe-project/MTurkDeployTemplate/blob/master/approve_HIT.py) and use `python approve_HIT.py YOUR_HIT_ID` to reimburse all workers. You can manipulate (expire, extend, ...) your HIT using `boto3` as described in the  [boto3 documentation](http://boto3.readthedocs.io/en/latest/index.html). For some recurrent manipulations, you can also use [this web interface](https://manage-hits-individually.s3.amazonaws.com/v4.0/index.html).




