## Feature Integration

This example implements a replication of experiment 1 from the Treisman & Gelade (1980) ("A feature-integration theory of attention" *Cognitive Psychology*: 12, 97-136). Participants see displays of colored letters and must look for a target. They respond via the keyboard indicating whether the target is present or absent from the display. The key finding is that single feature targets "pop-out" so that reaction times in *feature trials* are not increasing with increasing numbers of distractor elements in the display. In contrast, on *conjunction trials* where participants must look for a target which shares one feature with every distractor and is only unique in the conjunction of two features, reaction times are (linearly) increasing in the number of distractors.

This implementation of the experiment offers on-the-trial randomization of displays and a detailed feedback report after each trial, including the average reaction time and average hit rate by the participant so far.

More information about the experimental set-up and the code for this experiment can be found in the <a href="https://github.com/babe-project/FeatureIntegration" title="FeatureIntegration" target="_blank"> FeatureIntegration repository.</a>
