function [z]= grayslice(img,a,b)
row=size(img,1);
if size(img,3)==3
  z=rgb2gray(img);
else
  z=img;
end
z=z(:);
for i=1:length(z);
    if and(z(i)>=a,z(i)<=b)
        z(i)=255;
    else
        z(i)=0;
    end
end
z=vec2mat(z,row)';

return


