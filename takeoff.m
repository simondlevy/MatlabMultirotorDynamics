% Run simple altitude-hold PID controller to test dynamics
%
% Copyright (C) 2019 Simon D. Levy
%
% MIT License

DURATION = 40; % seconds

% PID params
ALT_P = 1.0;
VEL_P = 1.0;
VEL_I = 0;
VEL_D = 0;

% Time constant
DT = 0.001;

% Create PID controller
pid  = AltitudePidController(ALTITUDE_TARGET, ALT_P, VEL_P, VEL_I, VEL_D);

% Create dynamics
dyn = DjiPhantomDynamics;

% Initialize arrays for plotting
tvals = [];
uvals = [];
zvals = [];
vvals = [];

% Motors are initially off
u = 0;

% Start timing
tprev = 0;
tic

% Loop for duration
while tprev < DURATION
    
    % Set all the motors to the value obtained from the PID controller
    dyn = dyn.setMotors(u*ones(1,4));
    
    % Update the dynamics
    dyn = dyn.update(.001);
    
    % Get the current vehicle state vector
    s = dyn.getState();
    
    % Extract values from state vector, negating to handle NED coordinate system
    phi   =  s(MultirotorDynamics.STATE_PHI);
    theta =  s(MultirotorDynamics.STATE_THETA);
    psi   =  s(MultirotorDynamics.STATE_PSI);
    x     =  s(MultirotorDynamics.STATE_X);
    y     =  s(MultirotorDynamics.STATE_Y);
    z     = -s(MultirotorDynamics.STATE_Z);
    v     = -s(MultirotorDynamics.STATE_Z_DOT);
    
    % Show the vehicle
    showquad(phi, theta, psi, x, y, z)
    
    % Update the timer
    t = toc;
    dt = t - tprev;
    tprev = t;
    
    % Get correction from PID controller
    if dt > 0
        u = pid.u(z, v, dt);
    end
    
    % Constrain correction to [0,1] to represent motor value
    u = max(0, min(1, u));
    
    % Track values
    tvals = [tvals, t];
    zvals = [zvals, z];
    vvals = [vvals, v];
    uvals = [uvals, u];
    
    
end

% Plot results
figure
make_subplot(tvals, zvals, 1, 'Altitude (m)')
make_subplot(tvals, vvals, 2, 'Velocity (m/s)')
make_subplot(tvals, uvals, 3, 'Motors')
ylim([-.1,1.1])

function make_subplot(t, x, k, label)
subplot(3,1,k)
plot(t, x)
ylabel(label)
end
