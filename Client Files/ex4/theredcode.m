clear all;
obj = webcam(1);
set(obj,'Resolution','640x480');

load('ex4weights.mat');
imframe=zeros(480,640);
k=100;
se=strel('square',10);
preview(obj);
bg=double(rgb2gray(snapshot(obj)));
while 1
    
    frame=snapshot(obj);
    curframe=double(rgb2gray(frame));
    
    t=abs(bg-curframe);
    t=grayslice(t,15,255);
    t=imopen(t,se);
    bg=bg+min(abs(curframe-bg),15).*sign(curframe-bg);
    frame=rgb2ycbcr(frame);
    z=grayslice(frame(:,:,3),158,255);
    
   
    z=imopen(z,se);
   
    if and(z==0,max(max(imframe))~=0)
        k=imresize(imframe,[20 20]);
        k=k(:);
        p=predict2(Theta1,Theta2,k);
        disp('Predicted:');
        if p==10
            p=0;
        end
        p
        imframe=0;
    end
    
    
    show(:,1:size(z,2))=z(:,size(z,2):-1:1);
    t1(:,1:size(t,2))=t(:,size(t,2):-1:1);
    imframe=imframe+double(show);
    %imshow(t1);
    imshow(imframe);
    k=k-1;
    
end
 
