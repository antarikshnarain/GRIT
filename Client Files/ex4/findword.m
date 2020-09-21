function [maxword]=findword(b,plist)
max=0.0;
maxword='';
load c;
for i=1:size(plist{2},1)
    if size(b,2)==size(plist{1}{i},2)
        x=prob(b,plist{1}{i},c(plist{1}{i}));
        if max<=x
            max=x;
            maxword=plist{1}{i};
        end
    end
end
return