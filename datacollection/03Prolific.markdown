---
layout: datacollection
title: Recruiting participants via Prolific
redirect_from: /datacollection/1.html
section: datacollection
---

# {{ page.title }}

You can easily recruit participants for your _babe experiment via [Prolific](https://www.prolific.ac). The [ProlificDeployTemplate](https://github.com/babe-project/ProlificDeployTemplate) is a simple example to showcase how you can collect data with Prolific. The following assumes that you are familiar with how to operate experiments with Prolific.

Go to the Prolific website and create a new experiment. Make a note of the **completion URL** that is provided by Prolific.

<img src="https://raw.githubusercontent.com/babe-project/ProlificDeployTemplate/master/images/readme/prolific_url.png" width="100%" >

Next, you need to make two important changes to `config_deploy.js` (do not forget to upload/push these changes before launching the experiment!).

```javascript
var config_deploy = {
    ...
    "deployMethod" : "Prolific",
    "prolificURL": "https://app.prolific.ac/submissions/complete?cc=EZXBK7UQ", // as supplied by Prolific
    ...
};
```

First, you need to supply the experiment's **completion URL** that you obtained from the Prolific website. Second, you need to set the `deployMethod` to `Prolific`. The latter has two consequences. For one, it will insert a text input field in the introduction view of your experiment. For another, it will supply a `confirm` button at the end of the experiment, which takes participants to the Prolific website where they are supplied with their completion code.

The data from your experiment will _not_ be stored by Prolific, but recorded in the _babe back end. Before launching the study on Prolific, double-check that the data base on the back end is set up and the necessary information (`experimentID`, server URL) are set.