---
layout: experiments
title: Configuration
section: experiments
---

# {{ page.title }}

The user is free to add global config information in a file like `config/config_general.js`. Some templates do (like the SRP template (documentation pending)), but the minimal template does not. 

Every experiment needs information about **deployment**. Deployment is the way in which the experiment is realized and its collected data is processed. The user would normally only interact with the deployment configuration in file `config/config_deployment.js` by choosing one of the specified options as a string value for `deploymentMethod`, see code below: 

```javascript
var config_deploy = {

    // obligatory fields (unless in debug mode)

    // experimentID provided by _babe server app
    "experimentID": "YOUR_EXPERIMENT_ID",
    // if you use the _babe server app, specify its URL here
    "serverAppURL": "https://YOUR_SERVER_URL/api/submit_experiment/",

    // set deployment method; use one of:
    // 'debug', 'localServer', 'MTurk', 
    // 'MTurkSandbox', 'Prolific', 'directLink'
    "deployMethod": "debug",

    // who to contact in case of trouble
    "contact_email": "YOUREMAIL@wherelifeisgreat.you",
};

```

For the minimal template, we will only use the `debug` deployment method, which shows the final data as a table on the screen. This is the format in which you would get your data as a `*.csv` file if you would submit your data to a, say, crowd-sourcing platform or the _babe server app. How to do this is introduced in the [next section on deployment methods](deployment.html) and elaborated on in the [docs](../docs/).
