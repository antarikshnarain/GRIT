function exitGUI
global t connection flag
flag=0;
requestID='5';
if connection==1
    fprintf(t,'%s',requestID);
    fclose(t);
end
close('Client_GUI');
disp('Session OVER')
return