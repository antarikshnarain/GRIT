function ret=login()
global t handles
requestID='1';
% fprintf(t,'%s',requestID);
% while t.bytesAvailable==0
% end
% K=fread(t,t.bytesAvailable);
Id=input('Enter User ID: ');
Name=input('Enter User Name: ','s');
% fprintf(t,'%s',Id);
% while t.bytesAvailable==0
% end
% tmp=fread(t,t.bytesAvailable);
% fprintf(t,'%s',Name);
% while t.bytesAvailable==0
% end
% ret=fread(t,t.bytesAvailable)-48;
ret=1;
fprintf('Logged In As %s %s',Id,Name);
return