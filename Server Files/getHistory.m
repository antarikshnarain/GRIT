% retreive data for each userid
function mystr=getHistory(uid,sid,ptr)
global conn
tablename = sprintf('history%d',uid);
query = sprintf('select count(*) from %s where sid=%d',tablename,sid);
count = cell2mat(fetch(conn,query))
if ptr<count
    query = sprintf('select * from %s limit %d,1',tablename,ptr);
    data = fetch(conn,query);
    id = cell2mat(data(1));
    Msg = char(data(2));
    DtTime = char(data(3));
    query = sprintf('select name from user where id=%d',id);
    Sname =char(fetch(conn,query));
    mystr=sprintf('\n%s    |%s|%s',Msg,Sname,DtTime);
else
    mystr='NULL';
end
return