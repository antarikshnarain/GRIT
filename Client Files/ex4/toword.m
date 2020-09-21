function [word] = toword(a)
word=[];
for i=1:size(a,2)
    if a(i)<=10
        word = [word,char('0'+a(i)-1)];
    elseif a(i)<=36
        word = [word,char('A'+a(i)-11)];
    else
        word = [word,char('a'+a(i)-37)];
    end
end
return