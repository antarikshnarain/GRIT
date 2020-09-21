% retreive data for each userid
function [pos,mystr]=getChat(uid,sid,ptr)
global conn
if uid<sid
    tablename=sprintf('chat_%d_%d',uid,sid);
else
    tablename=sprintf('chat_%d_%d',sid,uid);
end
query = sprintf('select count(*) from %s',tablename);
count = cell2mat(fetch(conn,query));
pos=1;
if ptr<count
    query = sprintf('select * from %s limit %d,1',tablename,ptr);
    data = fetch(conn,query);
    id = cell2mat(data(1));
    Msg = char(data(2));
    DtTime = char(data(3));
    mystr=sprintf('%s\n',Msg);
    if id==sid
        pos=0;
    end
else
    mystr='NULL';
    pos=1;
end
return