num_im = 1;
canvas = imread('red_canvas.jpg');
scale = 1.5;

for i = 1:num_im
    file_name = strcat('img/brain_',sprintf('%03d',i),'.jpg');
    I = imread(file_name);
%     imshow(I);
    local_canvas = canvas;
    phi = 0;
    theta = 45;
    t = @(x) x(:,1).*-pi/10;
    f = @(x) [x(:,1).*cos(t(x))+x(:,2).*sin(t(x)),-x(:,1).*sin(t(x))+x(:,2).*cos(t(x))];
    g = @(x, unused) f(x);
    tform = maketform('custom', 2, 2, [], g, []);
    IM = imtransform(I, tform, 'UData', [-1 1], 'VData', [-1 1], ...
       'XData', [-1*scale scale], 'YData', [-1*scale scale]);
    dimz_b = size(IM);
    IM = imresize(IM,1920/dimz_b(2)); 
    Ir = imrotate(IM,theta);
    dimz = size(Ir);
    xshift = round(thetamap(theta, dimz(2),2048, 0));
    yshift = round(thetamap(theta, dimz(1),2048, 270));
    xphishift = (2048-xshift-dimz(2)/2)*phi/90;
    yphishift = (2048-yshift-dimz(1)/2)*phi/90;
    for y=1+yshift+yphishift:dimz(1)+yshift+yphishift
        for x=1+xshift+xphishift:dimz(2)+xshift+xphishift
            if sum(Ir(y -yshift-yphishift,x -xshift-yphishift,:)) > 0
                local_canvas(x,y,:) = Ir(y -yshift-yphishift,x -xshift-yphishift,:);
            end
            x_image = x_image + 1;
        end
        y_image = y_image + 1;
    end
    %local_canvas(1+yshift+yphishift:dimz(1)+yshift+yphishift,1+xshift+xphishift:dimz(2)+xshift+xphishift,:) = Ir;
    imshow(uint8(local_canvas));
    out_name = strcat('img/brainMap_',sprintf('%03d',i),'.jpg');
    %imwrite(local_canvas, out_name);
end

