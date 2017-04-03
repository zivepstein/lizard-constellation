 A = imread('peppers.png');
% A = A(31:330,1:500,:);
% figure
% imshow(A)
% title('Original Image','FontSize',14)
% 
% conformal = maketform('custom', 2, 2, [], @conformalInverse, []);
% 
% uData = [ -1.25   1.25];  % Bounds for REAL(w)
% vData = [  0.75  -0.75];  % Bounds for IMAG(w)
% xData = [ -2.4    2.4 ];  % Bounds for REAL(z)
% yData = [  2.0   -2.0 ];  % Bounds for IMAG(z)
% 
% B = imtransform( A, conformal, 'cubic', ...
%                 'UData', uData,'VData', vData,...
%                 'XData', xData,'YData', yData,...
%                 'Size', [300 360], 'FillValues', 255 );
% figure
% imshow(B)
% title('Transformed Image','FontSize',14)

%  img=load('clown');
%      figure;
%      [x,y,z]=sphere(128);
%      sh=surf(x,y,z);
%      set(sh,'facecolor','texturemap');
%      set(sh,'edgecolor','none');
%      set(sh,'cdata',flipud(img.X));
%      view(-45,45);
%      axis equal;
% 
in_im = imread('peppers.png');
udata = [0 1]; 
vdata = [0 1];
fill_color = 0;
org_rect = [0 0;1 0;1 1;0 1];
theta = 0;
R = [cos(theta) -sin(theta); sin(theta) cos(theta)];
trap = [-1 -2;2 -1;3 3;-3 1];
new_rect =  [-1 -2;2 -1;3 3;-3 1]; %[-1 -2;2 -1;3 3;-3 1];
for i = 1:4
    new_rect(i,:) = trap(i,:) * R;
end
tform = maketform('projective', org_rect, new_rect);
[out_im,xdata,ydata] = imtransform(in_im, tform, 'bicubic', 'udata', udata, 'vdata', vdata, 'size', size(in_im), 'fill', fill_color);
imshow(out_im,'XData',xdata,'YData',ydata);
% A = imread('peppers.png');
% uData = [ -1.25   1.25];  % Bounds for REAL(w)
% vData = [  0.75  -0.75];  % Bounds for IMAG(w)
% xData = [ -2.4    2.4 ];  % Bounds for REAL(z)
% yData = [  2.0   -2.0 ];  % Bounds for IMAG(z)
% ring = maketform('custom', 2, 2, [], @conformalInverseClip, []);
% Bring = imtransform( A, ring, 'cubic',...
%                     'UData', uData,  'VData', vData,...
%                     'XData', [-2 2], 'YData', yData,...
%                     'Size', [400 400], 'FillValues', 255 );
% figure
% imshow(Bring)
% title('Transformed Image With Masking','FontSize',14);