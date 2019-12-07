# Fitnetic
Fitness logging mobile app with AR/ML capabilities for 67-442 iOS Engineering.

Developed by Calvin Lui, Christina Chou, and Wilson Yu.

## AR/ML Features
Currently, we support AR/ML on two exercises: squats and jumping jacks (beta *aka not working well*). To activate AR/ML mode, tap the camera button during your workout. We recommend that you place your phone on the floor leaning against the wall, at an angle where your entire body is visible to the camera. The app will provide audio feedback.

**NOTE**: Your arms must be extended or touching your head while doing squats. This is part of our form checking, and improper reps will not be counted.

## Testing
This project uses SVGKit, which does not compile on simulators. So, to run the unit tests, a device must be plugged in and selected as the target.
