function [img,y] = chatconcat(img,c,y)
if not(y>0)
    y=max(1,size(c,1)-size(img,1));
end
if(and(size(img,2)~=size(c,2),size(c,1)~=0))
    img=imresize((img),[480 640]);
end

context = zeros(size(img,1),size(img,2));
context(1:min(size(context,1),size(c,1)-y),:)=(c(y+1:y+min(size(context,1),size(c,1)-y),:));
cont=not(context);

for i=1:3
     img(:,:,i)=img(:,:,i).*uint8(cont);
end

return

