% CODES 11->Data Available 10->Operation Successful
% CODE 1->newUser, 2->getData, 3->getHistory, 4->sendUser, 5->deleteUser
% t.RemotePort t.RemoteHost
function server_tcpip(id)
global t conn
conn = database('project','root','linuxmint','Vendor','MySQL');
setdbprefs('DataReturnFormat','cellarray');
t = tcpip('0.0.0.0',7000+id,'NetworkRole','server');
fprintf('Waiting for Client %d',id)
fopen(t);
fprintf('\nConnected %d\n',id)
% t.RemotePort
% t.RemoteHost
while 1
    disp('Waiting For Request From Client')
    while t.bytesAvailable == 0
    end
    requestID=fread(t,t.bytesAvailable);
    requestID=char(requestID);
    fprintf('Request ID: %s',requestID)
    switch requestID
        case '1'
            fprintf(t,'%s','waiting');
            while t.bytesAvailable==0
            end
            Uid=fread(t,t.bytesAvailable);
            Uid=char(Uid');
            fprintf(t,'Done');
            while t.bytesAvailable==0
            end
            Uname=fread(t,t.bytesAvailable);
            Uname=char(Uname');
            Uid=str2num(Uid);
            ret=newUser(Uid,Uname,t.RemoteHost,t.RemotePort,1);
            fprintf(t,'%d',ret)
            if ret==1
                fprintf('Client Connected\nID:%d, Name:%s, IP:%s, Port:%d\n',Uid,Uname,t.RemoteHost,t.RemotePort)
            else
                fprintf('\nClient Send Invalid Credentials')
            end
        case '2'
            %Get Data
            while 1
                str=getData(Uid)
                fprintf(t,'%s',str);
                while t.bytesAvailable==0
                end
                K=fread(t,t.bytesAvailable);
                if strcmp(str,'NULL')
                    break
                end
            end
        case '3'
            %Get Chat/History
            fprintf(t,'%s','waiting');
            while t.bytesAvailable == 0
            end
            local_sid=fread(t,t.bytesAvailable);
            Sid=str2num(char(local_sid'))
            ptr=0;
            while 1
                [pos str]=getChat(Uid,Sid,ptr)
                fprintf(t,'%d',pos);
                while t.bytesAvailable==0
                end
                K=fread(t,t.bytesAvailable);
                fprintf(t,'%s',str);
                while t.bytesAvailable==0
                end
                K=fread(t,t.bytesAvailable);
                if strcmp(str,'NULL')
                    break
                end
                ptr=ptr+1;
            end
        case '4'
            %Send User
            fprintf(t,'%s','waiting');
            while t.bytesAvailable==0
            end
            local_rid=fread(t,t.bytesAvailable);
            rid=str2num(char(local_rid'))
            fprintf(t,'%s','waiting');
            while t.bytesAvailable==0
            end
            Msg=fread(t,t.bytesAvailable);
            Msg=char(Msg');
            sendUser(rid,Uid,Msg)
        case '5'
            deleteUser(Uid)
            break
        case '6'
            ret=newUser(Uid,Uname,t.RemoteHost,t.RemotePort,0)
            break
    end
end
fprintf('Client Disconnected')
fclose(t);
close(conn);
return