function [cursw] = slide(img,sw,cursw,x)
ni=zeros(size(img,1),size(img,2)+floor((2/3)*sw(2)),size(img,3));
ni(:,floor(1/3*sw(2)):(floor(1/3*sw(2))+size(img,2)-1),:)=img;
ni=uint8(ni);
n=floor(size(img,2)/sw(2));
if abs(x)>1/50*sw(2)
    
    if or(or(and(cursw==1,x<0),and(cursw==n,x>0)),abs(x)<1/5*sw(2))
        if x<0
            peekl(ni,sw,cursw);
        else
            peekr(ni,sw,cursw);
        end
    else
        if x<0
            for i = 1:60:sw(2)
                imshow(ni(:,(floor(1/3*sw(2)+(cursw-1)*sw(2))-i):((floor(1/3*sw(2))+cursw*sw(2)-1)-i),:));
            end
            cursw=cursw-1;
            imshow(ni(:,(floor(1/3*sw(2)+(cursw-1)*sw(2))):((floor(1/3*sw(2))+cursw*sw(2)-1)),:));
        else
            for i=1:60:sw(2)
                imshow(ni(:,(floor(1/3*sw(2)+(cursw-1)*sw(2))+i):((floor(1/3*sw(2))+cursw*sw(2)-1)+i),:));
            end
            cursw=cursw+1;
            imshow(ni(:,(floor(1/3*sw(2)+(cursw-1)*sw(2))):((floor(1/3*sw(2))+cursw*sw(2)-1)),:));
        end    
    end
end

return