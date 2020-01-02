% Function to display a quadcopter in 3D
%
% Copyright (C) 2019 Simon D. Levy
%
% MIT License

classdef QuadDisplay

    properties(Constant, Access=private)

        WORLD_SIZE    = 10; 
        VEHICLE_SIZE  = 3;
        VEHICLE_COLOR = 'r';

    end

    properties(Access=private)
        d;
    end

    methods(Access=public)

        function obj = QuadDisplay
            s = obj.VEHICLE_SIZE / 2;
            obj.d = sqrt(s^2/2);
        end

        function show(obj, x, y, z, phi, theta, psi)

            p1 = [x-obj.d, y-obj.d, z];
            p2 = [x+obj.d, y+obj.d, z];

            p3 = [x-obj.d, y+obj.d, z];
            p4 = [x+obj.d, y-obj.d, z];


            obj.plotarm(p1, p2)
            hold on
            obj.plotarm(p3, p4)

            % Erase previous plot
            hold off

            axis([-obj.WORLD_SIZE obj.WORLD_SIZE -obj.WORLD_SIZE obj.WORLD_SIZE 0 obj.WORLD_SIZE])
            drawnow
        end

    end

    methods(Access=private)

        function plotarm(obj, p1, p2)
            plot3([p1(1),p2(1)], [p1(2), p2(2)], [p1(3),p2(3)], obj.VEHICLE_COLOR)
        end

    end

end 


