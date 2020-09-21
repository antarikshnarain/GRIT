function [k,r]= cslice3(img)
z=img;

z=z(:);
k=0;
a=0;
b=1;
r=[size(img,1) 0;size(img,2) 0];

for i=1:length(z)
    if and(z(i)>=a,z(i)<b)
        k=k+1;
        if(r(1,1)>(mod(i,size(img,1))+1))
            r(1,1)=mod(i,size(img,1))+1;
        end
        if(r(1,2)<(mod(i,size(img,1))+1))
            r(1,2)=mod(i,size(img,1))+1;
        end
        if(r(2,1)>((i)/size(img,1))+1)
            r(2,1)=((i)/size(img,1))+1;
        end
        if(r(2,2)<((i)/size(img,1))+1)
            r(2,2)=((i)/size(img,1))+1;
        end
            
     end
end
r=floor(r);
return