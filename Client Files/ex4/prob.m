function x = prob(a,b,c)
b=lower(b);
if size(b,2)~=size(a,2)
    x=0;
else
    x=1;
    for i=1:size(a,2)
        a(:,i)=a(:,i)/sum(a(:,i));
        x=x*(a(toclass(b(i)),i)+a(toclass(char(b(i)-32)),i))*c;
        
    end
end
return