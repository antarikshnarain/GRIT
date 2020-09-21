% CODES 11->Data Available 10->Operation Successful
% CODE 1->newUser, 2->getData, 3->getHistory, 4->sendUser, 5->deleteUser 
clc
clear all
addpath 'ex4';
load wtsn4;
global t flag connection sid
ip=input('Enter Server IP:','s');
flag=1;
connection=0;
for i=1:4
    t = tcpip(ip,7000+i,'NetworkRole','client');
    disp('Waiting for Connection')
    try
        fopen(t);
        connection=1;
        break
    catch
        disp('Server Busy')
    end
end
% t = tcpip('172.16.26.124',7000,'NetworkRole','client');
% disp('Waiting');
% fopen(t);
% disp('Connected');
fprintf('Connect to %d',i)
run('GUI1')
%disp('Session OVER')
    






