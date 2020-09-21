function [c] = pop(a)
if size(a,3)==3
    a=rgb2gray(a);
    b=im2bw(a);
else
    b=a;
end
    [k,r]=cslice3(b);
    c=b(r(1,1):r(1,2),r(2,1):r(2,2));
    if r(2,2)-r(2,1)>20
        c=imresize(c,[100 50]);
    else
        c=imresize(c,[100 20]);
        d=ones(100,50);
        d(:,15:34)=c;
        c=d;
    end
return
