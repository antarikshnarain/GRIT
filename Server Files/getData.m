% retreive data for each userid
function mystr=getData(uid)
global conn
tablename = sprintf('data%d',uid);
query = sprintf('select count(*) from %s',tablename);
count = cell2mat(fetch(conn,query));
if count~=0
    tablename = sprintf('data%d',uid);
    query = sprintf('select * from %s limit 1',tablename);
    data = fetch(conn,query);
    id = cell2mat(data(1));
    Msg = char(data(2));
    DtTime = char(data(3));
    query = sprintf('select name from user where id=%d',id);
    Sname =char(fetch(conn,query));
    query = sprintf('delete from %s limit 1',tablename);
    exec(conn,query);
    tablename = sprintf('history%d',uid);
    query = sprintf('insert into %s values(%d,''%s'',''%s'')',tablename,id,Msg,DtTime);
    exec(conn,query);
    mystr=sprintf('\n%s   |   %s   |   %s',Sname,Msg,DtTime);
else
    mystr='NULL';
end
return