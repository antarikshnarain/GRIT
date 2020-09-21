function str=getWord(IMG,Theta1,Theta2,plist)
str='';
[s,k]=wordsplit(IMG);
if size(k,1)==0
    return
end
[p,h]=predict(Theta1,Theta2,s);
%toword(p');
str=findword(h',plist);
return