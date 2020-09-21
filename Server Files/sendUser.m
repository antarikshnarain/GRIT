function ret=sendUser(uid,sid,smessage)
global conn
conn = database('project','root','linuxmint','Vendor','MySQL');
setdbprefs('DataReturnFormat','cellarray');
query = sprintf('select available from User where id=%d',uid);
B=fetch(conn,query);
if isempty(B)
    ret='User DoesNot Exist';
    return
end
davail = cell2mat(B); % cell2mat converts cellarray to matrix
tablename = sprintf('data%d',uid);
dateandtime = char(datetime('now'));
query = sprintf('insert into %s values(%d,''%s'',''%s'')',tablename,sid,smessage,dateandtime);
exec(conn,query);
if uid<sid
    tablename=sprintf('chat_%d_%d',uid,sid);
else
    tablename=sprintf('chat_%d_%d',sid,uid);
end
query=sprintf('create table %s(id int,msg varchar(50),datetime varchar(30))',tablename);
exec(conn,query);
query=sprintf('insert into %s values(%d,''%s'',''%s'')',tablename,sid,smessage,dateandtime);
exec(conn,query);
if davail == 0
    ret='SERVER: Receiver Not Available, Saving Message';
else
    ret='SERVER: Message Send!';
end
return