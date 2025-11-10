begin;
insert into users (username, email, created_at) values ('harry', 'harry@example.com', now());
update users set username = 'hammond' where username = 'harry';
select id, username, email, created_at from users where created_at > '2024-03-01';
delete from users where char_length(username) = 5;
select * from users;
rollback;