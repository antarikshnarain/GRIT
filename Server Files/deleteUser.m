function deleteUser(uid)
global conn
conn = database('project','root','linuxmint','Vendor','MySQL');
setdbprefs('DataReturnFormat','cellarray');
query = sprintf('select name from User where id=%d',uid);
B = fetch(conn,query);
name = char(B);
if strcmp(name,'')==1
    fprintf('NO User Exists with UserID: %d\n',uid)
    return
end
query = sprintf('delete from user where id=%d',uid);
exec(conn,query);
disp('Removed User from User''s List')
tablename=sprintf('data%d',uid);
query = sprintf('drop table %s',tablename);
exec(conn,query);
% tablename=sprintf('history%d',uid);
% query = sprintf('drop table %s',tablename);
% exec(conn,query);
disp('History and Data Tables removed of Users')
return