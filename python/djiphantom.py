#!/usr/bin/env python3
'''
Dynamics class for DJI Inspire

Copyright (C) 2019 Simon D. Levy

MIT License
'''

from gym_copter.dynamics import Parameters
from gym_copter.dynamics.quadxap import QuadXAPDynamics

class DJIPhantomDynamics(QuadXAPDynamics):

    def __init__(self):

        QuadXAPDynamics.__init__(self, Parameters(

            # Estimated
            5.E-06, # b
            2.E-06, # d

            # https:#www.dji.com/phantom-4/info
            1.380,  # m (kg)
            0.350,  # l (meters)

            # Estimated
            2,      # Ix
            2,      # Iy
            3,      # Iz
            38E-04, # Jr
            15000   # maxrpm
            ))

if __name__ == '__main__':

    dyn = DJIPhantomDynamics()

    while True:
        dyn.setMotors((1,1,1,1))
        dyn.update(.001)
        print('Alt = %3.2fm' % (-dyn.getState()[5]))
