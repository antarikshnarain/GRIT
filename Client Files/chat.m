function [oldchat]=chat(oldchat,s,ros,pros)%ros==1 received msg, ros==0 sent msg
if ros == 1
    b=imread('b1.png');
else
    b=imread('b2.png');
end
if size(s,2)>13
    b=imresize(b,[size(b,1) size(s,2)*20]);
end
si=text2im(s);
b(15:(14+size(si,1)),15:(14+size(si,2)))=si;

if(size(oldchat,2)~=0)
    o=zeros(size(b,1),size(oldchat,2));
else
    o=zeros(size(b,1),640);
end
if pros==1
    b(1:15,:)=ones(15,size(b,2));
end
    
if (ros==1)
    o(:,1:size(b,2))=b;
else
    o(:,(640-size(b,2)+1):640)=b;
end
if and(pros==1,size(oldchat,2)~=0)
    oldchat=oldchat(1:(size(oldchat,1)-40),:);
end
   oldchat=[oldchat;o];
return 