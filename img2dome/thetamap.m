
function coord = thetamap(theta, rect_side, r,offset)
% if theta <= 180
%     coord = offset + theta*(2*r-rect_side)/180;
% else 
%     coord = offset +4*r - 2*rect_side +  theta*(rect_side-2*r)/180;
    coord = (2*r-rect_side)/2 *(1+sin((theta-offset)*pi/180))
end
% 
%   if theta <= 135
%         xshift=theta*r/135;
%         yshift=4096/2 + (4096/2 - dimz(1))*(1-theta/45);
%     elseif theta <= 180
%         xshift=4096/2 + (4096/2 - dimz(2))*(theta/45-1);
%         yshift=4096/2 - (dimz(1)/2)*(theta/45-1);
%      elseif theta <= 135
%         xshift=4096/2 + (4096/2 - dimz(2));
%         yshift=(4096/2 - (dimz(1)/2) )* (theta) ;
%     end
