---
layout: experiments
title: Deploy configuation
section: experiments
---

# {{ page.title }}

Every experiment needs information about **deployment**. Deployment is the way in which the experiment is realized and the way in which the data collected by the experiment is processed. Information about deployment is given in the file `06_main.js`, by setting the properties of the `deploy` object, as shown below:

```javascript
 magpieInit({
        ...
        deploy: {
            experimentID: "INSERT_A_NUMBER",
            serverAppURL: "https://magpie-demo.herokuapp.com/api/submit_experiment/",
            // Possible deployment methods are:
            // "debug" and "directLink"
            // As well as "MTurk", "MTurkSandbox" and "Prolific"
            deployMethod: "debug",
            contact_email: "YOUREMAIL@wherelifeisgreat.you",
            prolificURL: "https://app.prolific.ac/submissions/complete?cc=SAMPLE1234"
        }
        ...
    });
```

The most important field is `deployMethod`. When you develop your experiment, you will initially only use the `debug` deployment method, which shows the final data as a table on the screen. Information about other means of and ways of collecting data via crowd-sourcing platforms like Amazon's Mechanical Turk or Prolific are provided in the [docs](https://magpie-ea.github.io/magpie-docs/03_deploying_experiments/01_configuration/).


