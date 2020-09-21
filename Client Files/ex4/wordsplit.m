function [wordarray,pic] = wordsplit(img)
a=rgb2gray(img);
a=im2bw(a);
b=not(a);
wordarray=[];
pic=[];
i=1;
j=1;
while i<=size(a,2)
while and(not(sum(b(:,i))),i<size(a,2))
i=i+1;
end
if i==size(a,2)
    break;
end
j=i;
while and((sum(b(:,i))),i<size(a,2))
i=i+1;
end
k=pop(a(:,j:i));
wordarray=[wordarray;k(:)'];
pic = [pic;k];
end
return
