function [word] = toclass(a)
word=[];
for i=1:size(a,2)
    if a(i)<='9'
        word = [word,a(i)-'0'+1];
    elseif a(i)<='Z'
        word = [word,a(i)-'A'+11];
    else
        word = [word,a(i)-'a'+37];
    end
end
return