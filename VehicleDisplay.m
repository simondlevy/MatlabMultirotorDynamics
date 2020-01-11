% Function to display a multicopter in 3D
%
% Copyright (C) 2019 Simon D. Levy
%
% MIT License

classdef VehicleDisplay
    
    properties(Constant, Access=private)
        
        VEHICLE_SIZE      = 3;
        PROPELLER_RADIUS  = 0.5;
        PROPELLER_OFFSET  = 0.1;
        WORLD_SIZE        = 20;
    end
    
    properties(Access=private)
        d;
    end
    
    methods(Access=public)
        
        function obj = VehicleDisplay
            s = obj.VEHICLE_SIZE / 2;
            obj.d = sqrt(s^2/2);
        end
        
        function show(obj, x, y, z, phi, theta, psi, msg)
            % Angles in radians
                        
            h = [];
            h = [h,obj.plotarm(x, y, z, -1, -1, +1, +1)];
            hold on
            h = [h,obj.plotarm(x, y, z, -1, +1, +1, -1)];
                        
            hold off
             
            axis([-obj.WORLD_SIZE obj.WORLD_SIZE -obj.WORLD_SIZE obj.WORLD_SIZE 0 obj.WORLD_SIZE])
            
            rotate(h, [0 0 1],  rad2deg(psi))
            rotate(h, [0 1 0],  rad2deg(theta))
            rotate(h, [1 0 0], -rad2deg(phi))

            if nargin > 7
                title(msg)
            end
            
            xlabel('X (m)')
            ylabel('Y (m)')
            zlabel('Z (m)')

            drawnow

        end
        
    end
    
    methods(Access=private)
        
        function h = plotarm(obj, x, y, z, dx1,dy1, dx2, dy2)
            x1 = x+dx1*obj.d;
            x2 = x+dx2*obj.d;
            y1 = y+dy1*obj.d;
            y2 = y+dy2*obj.d;
            h = plot3([x1,x2], [y1,y2], [z,z],'k');
            h = [h, obj.plotprop(x1, y1, z, 'b')];
            h = [h, obj.plotprop(x2, y2, z, 'r')];
        end
        
        function h = plotprop(obj, x, y, z, c)
            hold on
            th = 0:pi/50:2*pi;
            xunit = obj.PROPELLER_RADIUS * cos(th) + x;
            yunit = obj.PROPELLER_RADIUS * sin(th) + y;
            zunit = (z+obj.PROPELLER_OFFSET) * ones(size(xunit));
            h = plot3(xunit, yunit, zunit, c);
            hold off
        end
        
    end
    
end


