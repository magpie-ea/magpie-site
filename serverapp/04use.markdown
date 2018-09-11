---
layout: serverapp
title: Using the server app
section: serverapp
---

# {{ page.title }}

After installation you can visit the server app in a browser. (TODO: Specify how to retrieve
URL!) The server app shows a list of experiments for which data exists in the database. It
shows the experiments ID, its name, its author, the number of submissions retrieved so far,
date information, as well as whether the experiment is currently active or not. If an
experiment is set to be active, it allows further submissions to be recorded in its
database.

<img src="../images/server_app_screen.png" width="100%">

The server app allows you to retrieve the data for an experiment from its database. Simply
click on the button "retrieve CSV" to download a CSV-file with the data collected so far. 

To delete an experiment, click the "delete" button. Always make sure that you have recovered
all necessary data from that experiment; otherwise your data collected so far might be
irrevocably lost.

You can also edit an experiment with the "edit" button. You can change information about the
experiment on the edit-screen. You can also toggle whether the experiment is active or not. You
can set a maximum number of submissions after which the experiment automatically toggles its
activity status off. Any submission made by a participant to a non-active experiment is just
lost and will not be recorded. This is to protect your database from pollution or attacks, but
if used unwisely could also cause you loss of relevant data.

Finally, the server app allows you to create a new database for your experiment. Click on the
"new" button to do this. The interface for creating a new experiment is parallel to editing an
existing experiment. Importantly, however you need to give some required information about a
new experiment (name and author). If you want to use dynamic retrieval of experiment data
(TODO: document and insert link), you must specify which fields should be visible at first
creation of the experiment.


