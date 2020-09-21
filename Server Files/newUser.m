% Handling User Table for
% Adding, Updating and Authenticating User
% ALSO altering data into table for Available and Unavailable
% Returns true if user valid or new user created
function ret=newUser(uid,uname,uip,uport,uavail)
global conn
ret=1;
query = sprintf('select name from User where id=%d',uid);
name = char(fetch(conn,query));
if strcmp(name,'')==1
    % Operations : Add User, Create data_id,history_id
    disp('Adding NEW USER to the Server')
    query = sprintf('insert into User(id,name,ipaddress,port,available) values(%d,''%s'',''%s'',%d,%d)',uid,uname,uip,uport,uavail);
    exec(conn,query);
    tablename = sprintf('data%d',uid);
    query = sprintf('create table %s(sid int,smsg varchar(100),datetime varchar(30),foreign key(sid) references User(id) on delete cascade)',tablename);
    exec(conn,query);
elseif strcmp(name,uname)==1
    if uavail ==1
        disp('Existing USER Logging IN to the Server')
    else
        disp('USER Logging OUT from the Server')
    end
    query = sprintf('update user set port=%d,ipaddress=''%s'',available=%d where id=%d',uport,uip,uavail,uid);
    exec(conn,query);
else
    disp('ID and UserName didnot Match')
    ret=0;
end
return