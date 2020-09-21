function [y] = chatscroll(img,c,y,disp)
if not(y>0)
    y=max(1,size(c,1)-size(img,1));
end
if abs(disp)>15
   if disp>0
       k=y;
       for i=y:5*ceil(disp/200):min(y+disp,size(c,1)-200)
           [r,y]=chatconcat(img,c,i);
           imshow(r);
       end
       [r,y]=chatconcat(img,c,max(k+disp,1));
       imshow(r);
   else
       k=y;
         for i=y:5*ceil(disp/200):max(y+disp,1)
           [r,y]=chatconcat(img,c,i);
           imshow(r);
         end
         [r,y]=chatconcat(img,c,max(k+disp,1));
         imshow(r);
   end
end
return