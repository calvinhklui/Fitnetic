# Fitnetic
Supercharge your 7-Minute Workout with Fitnetic, a data-driven application that leverages Augmented Reality and Machine Learning to improve your home gym experience.

Developed by Calvin Lui, Christina Chou, and Wilson Yu for 67-442 iOS Engineering at Carnegie Mellon University.

## Screenshots

| Home | Workout | Squats |
| :----: | :----: | :----: |
| <img src="Screenshots/fitneticHome.jpeg"> | <img src="Screenshots/fitneticWorkout.jpeg"> | <img src="Screenshots/fitneticSquats.gif"> |

| Calendar | Body Map | History |
| :----: | :----: | :----: |
| <img src="Screenshots/fitneticCalendar.jpeg"> | <img src="Screenshots/fitneticBodymap.jpeg"> | <img src="Screenshots/fitneticHistory.jpeg"> |

## For Graders
Currently, we support AR/ML on two exercises: squats and jumping jacks (beta *aka not working well*). To activate AR/ML mode, tap the camera button during your workout. We recommend that you place your phone on the floor leaning against the wall, at an angle where your entire body is visible to the camera. The app will provide audio feedback.

**NOTE**: Your arms must be extended or touching your head while doing squats. This is part of our form checking, and improper reps will not be counted.

## Testing
This project uses SVGKit, which does not compile on simulators. So, to run the unit tests, a device must be plugged in and selected as the target.
