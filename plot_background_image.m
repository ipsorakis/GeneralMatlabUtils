% This creates the 'background' axes
ha = axes('units','normalized', ...
'position',[0 0 1 1]);

% Move the background axes to the bottom
uistack(ha,'bottom');

% Load in a background image and display it using the correct colors
% The image used below, is in the Image Processing Toolbox. If you do not have %access...
%to this toolbox, you can use another image file instead.
I=imread('wytham_map.jpg');
hi = imagesc(I)
colormap gray

%hold
%plot(rand(10))

% Turn the handlevisibility off so that we don't inadvertently plot into the axes again
% Also, make the axes invisible
set(ha,'handlevisibility','off','visible','off')

% Now we can use the figure, as required.
% For example, we can put a plot in an axes
axes('position',[0.3,0.35,0.4,0.4])
plot(rand(10))
set(hi,'alphadata',.5)