% This script is written and read by pdetool and should NOT be edited.
% There are two recommended alternatives:
 % 1) Export the required variables from pdetool and create a MATLAB script
 %    to perform operations on these.
 % 2) Define the problem completely using a MATLAB script. See
 %    http://www.mathworks.com/help/pde/examples/index.html for examples
 %    of this approach.


% Geometry description:
polesNumber                 =   6;      %Number of poles
poleDistance                =   50;     %Pole distance
seconedaryCoreThickness     =   10;     %Secondary core thickness
pmLength                    =   30;     %PM length
pmThickness                 =   10;     %PM thickness

%Air gap parameter
airGapWidth                 =   1;      %Air gap width

%Primary parameter
slotsNumber                 =   3;      %Number of slots
slotWidth                   =   30;     %Slot width
slotOpeningWidth            =   20;     %Slot opening width
toothTangDepthStraight      =   5;      %Tooth tang depth (straight part)
toothTangDepthOblique       =   5;      %Tooth tang depth (oblique part)
slotHeight                  =   30;     %Slot height
yokeWidth                   =   10;     %Yoke width

%Initialize PDE tool
[pdeFig,ax]                 =   pdeinit;
pdetool('appl_cb',6);
set(ax,'Xlim',[0,polesNumber*poleDistance]);
set(ax,'Ylim',[-50,seconedaryCoreThickness+pmThickness+airGapWidth+slotHeight+yokeWidth+50]);
set(ax,'XTickMode','auto');
set(ax,'YTickMode','auto');

%Plot secondary core with 'pderect' commend, which needs the array [x_min, 
%x_max, y_min, y_max]. The first point of secondary core is the origin.
xySecondaryCore = [0,...                                %x_min
                   polesNumber*poleDistance,...         %x_max
                   0,...                                %y_min
                   seconedaryCoreThickness];            %y_max
pderect(xySecondaryCore,'R1');

%Plot secondary magnets with 'pderect' comment.
for i = 1:polesNumber
    xySecondaryMagnets=[(poleDistance-pmLength)/2+1+(i-1)*poleDistance,...      %x_min
                          (poleDistance+pmLength)/2-1+(i-1)*poleDistance,...    %x_max
                          seconedaryCoreThickness,...                           %y_min
                          seconedaryCoreThickness+pmThickness];                 %y_max
    xyMagnetsEquCurrent1=[(poleDistance-pmLength)/2+(i-1)*poleDistance,...      %x_min
                          (poleDistance-pmLength)/2+1+(i-1)*poleDistance,...    %x_max                          
                          seconedaryCoreThickness,...                           %y_min                           
                          seconedaryCoreThickness+pmThickness];                 %y_max
    xyMagnetsEquCurrent2=[(poleDistance+pmLength)/2-1+(i-1)*poleDistance,...    %x_min
                          (poleDistance+pmLength)/2+(i-1)*poleDistance,...      %x_max                          
                          seconedaryCoreThickness,...                           %y_min                           
                          seconedaryCoreThickness+pmThickness];                 %y_max                      
    pderect(xySecondaryMagnets,['R',mat2str(3*i-1)]);
    pderect(xyMagnetsEquCurrent1,['R',mat2str(3*i)]);
    pderect(xyMagnetsEquCurrent2,['R',mat2str(3*i+1)]);
end

%Plot primary core with 'pdepoly' comment.
for i =1:slotsNumber;
    xPrimaryCore =   [slotOpeningWidth/2+(i-1)*polesNumber*poleDistance/slotsNumber,...                     %x_1
                      slotOpeningWidth/2+(i-1)*polesNumber*poleDistance/slotsNumber,...                     %x_2
                      slotWidth/2+(i-1)*polesNumber*poleDistance/slotsNumber,...                     %x_3
                      slotWidth/2+(i-1)*polesNumber*poleDistance/slotsNumber,...                     %x_4
                      0+(i-1)*polesNumber*poleDistance/slotsNumber,...                         %x_5
                      0+(i-1)*polesNumber*poleDistance/slotsNumber,...                         %x_6
                      polesNumber*poleDistance/slotsNumber+(i-1)*polesNumber*poleDistance/slotsNumber,...         %x_7
                      polesNumber*poleDistance/slotsNumber+(i-1)*polesNumber*poleDistance/slotsNumber,...         %x_8
                      polesNumber*poleDistance/slotsNumber-slotWidth/2+(i-1)*polesNumber*poleDistance/slotsNumber,...   %x_9
                      polesNumber*poleDistance/slotsNumber-slotWidth/2+(i-1)*polesNumber*poleDistance/slotsNumber,...   %x_10
                      polesNumber*poleDistance/slotsNumber-slotOpeningWidth/2+(i-1)*polesNumber*poleDistance/slotsNumber,...   %x_11
                      polesNumber*poleDistance/slotsNumber-slotOpeningWidth/2+(i-1)*polesNumber*poleDistance/slotsNumber];     %x_12
    yPrimaryCore =   [seconedaryCoreThickness+pmThickness+airGapWidth,...             %y_1
                      seconedaryCoreThickness+pmThickness+airGapWidth+toothTangDepthStraight,...         %y_2
                      seconedaryCoreThickness+pmThickness+airGapWidth+toothTangDepthStraight+toothTangDepthOblique,...     %y_3
                      seconedaryCoreThickness+pmThickness+airGapWidth+slotHeight,...       %y_4
                      seconedaryCoreThickness+pmThickness+airGapWidth+slotHeight,...       %y_5
                      seconedaryCoreThickness+pmThickness+airGapWidth+slotHeight+yokeWidth,...   %y_6
                      seconedaryCoreThickness+pmThickness+airGapWidth+slotHeight+yokeWidth,...   %y_7
                      seconedaryCoreThickness+pmThickness+airGapWidth+slotHeight,...       %y_8
                      seconedaryCoreThickness+pmThickness+airGapWidth+slotHeight,...       %y_9
                      seconedaryCoreThickness+pmThickness+airGapWidth+toothTangDepthStraight+toothTangDepthOblique,...     %y_10
                      seconedaryCoreThickness+pmThickness+airGapWidth+toothTangDepthStraight,...         %y_11
                      seconedaryCoreThickness+pmThickness+airGapWidth];               %y_12
    pdepoly(xPrimaryCore,yPrimaryCore,['P',mat2str(i)]);
end

%Plot air region
xy_air_region = [0,...
                 polesNumber*poleDistance,...
                 -30,...
                 seconedaryCoreThickness+pmThickness+airGapWidth+slotHeight+yokeWidth+30];
pderect(xy_air_region,'R_air');

%set(findobj(get(pde_fig,'Children'),'Tag','PDEEval'),'String','R1+R2+R3+R4+R5+R6+R7+R8+R9+R10+R11+R12+R13+P1+P2+P3+R14')

% Boundary conditions:
pdetool('changemode',0)
pdesetbd(24,'dir',1,'1','0')
pdesetbd(25,'dir',1,'1','0')
pdesetbd(81,'neu',1,'1','0')
pdesetbd(82,'neu',1,'1','0')
pdesetbd(83,'neu',1,'1','0')
pdesetbd(84,'neu',1,'1','0')
pdesetbd(85,'neu',1,'1','0')
pdesetbd(86,'neu',1,'1','0')
pdesetbd(87,'neu',1,'1','0')
pdesetbd(88,'neu',1,'1','0')
pdesetbd(89,'neu',1,'1','0')
pdesetbd(90,'neu',1,'1','0')
% Mesh generation:
setappdata(pdeFig,'Hgrad',1.3);
setappdata(pdeFig,'refinemethod','regular');
setappdata(pdeFig,'jiggle',char('on','mean',''));
setappdata(pdeFig,'MesherVersion','preR2013a');
pdetool('initmesh')

% PDE coefficients:
pdeseteq(1,...
'1./(4*pi*10^(-7))!1./(4*pi*10^(-7)*5000)!1./(4*pi*10^(-7)*5000)!1./(4*pi*10^(-7)*5000)!1./(4*pi*10^(-7))!1./( 4*pi*10^(-7))!1./(4*pi*10^(-7))!1./( 4*pi*10^(-7))!1./(4*pi*10^(-7))!1./( 4*pi*10^(-7))!1./(4*pi*10^(-7))!1./(4*pi*10^(-7)*5000)!1./( 4*pi*10^(-7))!1./( 4*pi*10^(-7))!1./( 4*pi*10^(-7))!1./( 4*pi*10^(-7))!1./( 4*pi*10^(-7))',...
'0.0!0.0!0.0!0.0!0.0!0.0!0.0!0.0!0.0!0.0!0.0!0.0!0.0!0.0!0.0!0.0!0.0',...
'0!0!0!0!0!-1.0!0!1.0!0!-1.0!0!0!1.0!-1.0!1.0!-1.0!1.0',...
'1.0!1.0!1.0!1.0!1.0!1.0!1.0!1.0!1.0!1.0!1.0!1.0!1.0!1.0!1.0!1.0!1.0',...
'0:10',...
'0.0',...
'0.0',...
'[0 100]')
setappdata(pdeFig,'currparam',...
['4*pi*10^(-7)!4*pi*10^(-7)*5000!4*pi*10^(-7)*5000!4*pi*10^(-7)*5000!4*pi*10^(-7)! 4*pi*10^(-7)!4*pi*10^(-7)! 4*pi*10^(-7)!4*pi*10^(-7)! 4*pi*10^(-7)!4*pi*10^(-7)!4*pi*10^(-7)*5000! 4*pi*10^(-7)! 4*pi*10^(-7)! 4*pi*10^(-7)! 4*pi*10^(-7)! 4*pi*10^(-7)';...
'0!0!0!0!0!-1.0!0!1.0!0!-1.0!0!0!1.0!-1.0!1.0!-1.0!1.0                                                                                                                                                                                                   '])

% Solve parameters:
setappdata(pdeFig,'solveparam',...
char('0','6078','10','pdeadworst',...
'0.5','longest','0','1E-4','','fixed','Inf'))

% Plotflags and user data strings:
setappdata(pdeFig,'plotflags',[1 1 1 1 1 1 1 1 0 0 0 1 0 1 0 1 0 1]);
setappdata(pdeFig,'colstring','');
setappdata(pdeFig,'arrowstring','');
setappdata(pdeFig,'deformstring','');
setappdata(pdeFig,'heightstring','');

% Solve PDE:
pdetool('solve')
