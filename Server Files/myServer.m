% CODES 11->Data Available 10->Operation Successful
% CODE 1->newUser, 2->getData, 3->getHistory, 4->sendUser, 5->deleteUser 
clc
clear all
parfor i=1:4
    server_tcpip(i);
end
%server_tcpip(0);

