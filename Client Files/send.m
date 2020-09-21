function send
global t 
requestID='4';
fprintf(t,'%s',requestID);
while t.bytesAvailable==0
end
K=fread(t,t.bytesAvailable);
local_sid=get(handles.edit2,'String');
local_message=get(handles.edit1,'String');
if isempty(char(local_sid))==1
    msgbox('No Sid Defined');
    return;
elseif isempty(char(local_message))==1
    msgbox('Message Box Empty');
    return;
end
fprintf(t,local_sid);
while t.bytesAvailable==0
end
K=fread(t,t.bytesAvailable);
fprintf(t,local_message);
disp('Data Sent')
return