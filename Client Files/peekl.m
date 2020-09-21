function peekl(img,sw,cursw)
cursw=mod(cursw-1,floor(size(img,2)/sw(2)))+1;
context=(img(:,floor(1/3*sw(2)+(cursw-1)*sw(2)):(floor(1/3*sw(2))+cursw*sw(2)-1),:));
for i=0:30:floor(sw(2)/4)
    imshow(img(:,(floor(1/3*sw(2)+(cursw-1)*sw(2))-i):((floor(1/3*sw(2))+cursw*sw(2)-1)-i),:));
end
for i=floor(sw(2)/4):-45:0
    imshow(img(:,(floor(1/3*sw(2)+(cursw-1)*sw(2))-i):((floor(1/3*sw(2))+cursw*sw(2)-1)-i),:));
end
imshow(context);
return