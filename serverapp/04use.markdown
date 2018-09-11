---
layout: serverapp
title: Using the server app
section: serverapp
---

# {{ page.title }}

After installation you can visit the server app in a browser, with the username and password you previously specified. For Heroku deployment, you may do so by running `heroku open` in the command line or find the app URL in your Heroku account. For local deployment, the URL is by default http://localhost:4000.

The server app shows a list of experiments whose data may be stored in the database. It
shows the experiments ID, its name, its author, the number of submissions retrieved so far,
date information, as well as whether the experiment is currently active or not. If an
experiment is set to be active, it allows further submissions to be recorded in its
database.

<img src="../images/server_app_screen.png" width="100%">

The server app allows you to retrieve the data for an experiment from its database. Simply
click on the button "Retrieve CSV" to download a CSV-file with the data collected so far.

To delete an experiment, click the "Delete" button. Always make sure that you have recovered
all necessary data from that experiment; otherwise your data collected so far might be
irrevocably lost.

You can also edit an experiment with the "Edit" button. You can change information about the
experiment on the edit-screen. You can also toggle whether the experiment is active or not. You
can set a maximum number of submissions after which the experiment automatically toggles its
activity status off. Any submission made by a participant to a non-active experiment is just
lost and will not be recorded. This is to protect your database from pollution or attacks, but
if used unwisely could also cause you loss of relevant data.

Finally, the server app allows you to create and manage new experiments. Click on the
"New" button to do this. The interface for creating a new experiment is parallel to editing an
existing experiment. Importantly, you need to give some required information about a
new experiment (name and author). If you want to use dynamic retrieval of experiment data
(TODO: document and insert link), you must specify which fields should be available to be retrieved by your API calls. This allows you to expose only the relevant fields, since the dynamic retrieval API is not password protected by default.
