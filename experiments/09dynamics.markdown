---
layout: experiments
title: Dynamic data retrieval
section: experiments
---

# {{ page.title }}

For some experiments, it might helpful to fetch and use data collected from previous experiment submissions in order to dynamically generate future trials. The _magpie backend now provides this functionality.

For each experiment, you can specify the keys that should be fetched in the "Edit Experiment" user interface on the server app. Then, with a HTTP GET call to the `retrieve_experiment` endpoint, specifying the experiment ID, you will be able to get a JSON object that contains the results of that experiment so far.

`{SERVER_ADDRESS}/api/retrieve_experiment/:id`

A [minimal example](https://jsfiddle.net/SZJX/dp8ewnfx/) of frontend code using jQuery:

```javascript
  $.ajax({
    type: 'GET',
    url: "https://magpie-demo.herokuapp.com/api/retrieve_experiment/1",
    crossDomain: true,
    success: function (responseData, textStatus, jqXHR) {
    	console.table(responseData);
    }
  });
```

