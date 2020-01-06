<img src="takeoff.png" align="left" width="400">
<img src="takeoff.gif" width="400">


This folder contains a Matlab implementation of the quadcopter dynamics equations in
([Bouabdallah et al. 2004](https://infoscience.epfl.ch/record/97532/files/325.pdf)),
extended to work with general multi-copter (quad, hex, octo) configurations.  

## Quickstart

Launch Matlab, change your working directory to where you installed this repository, and do
```
  >> takeoff(10, .001);
```

This will run a simple [PID controller](https://en.wikipedia.org/wiki/PID_controller) to make a simulated 
quadcopter rise from the ground to 10 meters altitude, over a period of 40 seconds.

## Playback

The takeoff script returns an array of kinematic frames consisting of the current time and vehicle pose
(x, y, z, roll, pitch, yaw).  This array can be passed to a playback script to display a 3D movie:

```
  >> a = takeoff(10, .001);
  >> playback(a)
```

## Related projects

[gym-copter](https://github.com/simondlevy/levy/gym-copter)

[MulticopterSim](https://github.com/simondlevy/levy/MulticopterSim)

