function [J,img]= processFrame(data,color,J,func)
if color==2
    color=3;
end
diff_im = imsubtract(data(:,:,color), rgb2gray(data));
diff_im = medfilt2(diff_im, [3 3]);
diff_im = im2bw(diff_im,0.18);
diff_im = bwareaopen(diff_im,300);
bw = bwlabel(diff_im, 8);
stats = regionprops(bw, 'BoundingBox', 'Centroid');

if isempty(stats)==1
    switch func
        case 'Leave'
            leave();
            fprintf('%s',func);
        case 'Login'
            ret=login();
            if ret==1
                set(handles.text2,'String','CONNECTED !');
            else
                set(handles.text2,'String','DISCONNECTED !');
            end
            fprintf('%s',func);
        case 'Exit'
            fprintf('%s',func);
            exitGUI();
        case 'Unread'
            fprintf('%s',func);
        case 'Chat'
            fprintf('%s',func);
    end
end

% Display the image
if color==1
    J=J+bw2rgb(diff_im);
    img=data+J;
else
    img=data;
end
imshow(img);

hold on
%This is a loop to bound the red objects in a rectangular box.
for object = 1:length(stats)
    bb = stats(object).BoundingBox;
    bc = stats(object).Centroid;
    rectangle('Position',bb,'EdgeColor','r','LineWidth',2)
    plot(bc(1),bc(2), '-m+')
    func=getButton(bc(1),480-bc(2));
    a=text(bc(1)+15,bc(2), strcat('X: ', num2str(round(bc(1))), '    Y: ', num2str(round(bc(2)))));
    set(a, 'FontName', 'Arial', 'FontWeight', 'bold', 'FontSize', 12, 'Color', 'yellow');
end
hold off