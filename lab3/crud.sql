begin;
insert into users (username, email, created_at) values ('harry', 'harry@example.com', now());
update users set username = 'hammond' where username = 'harry';
select id, username, email, created_at from users where created_at > '2024-03-01';
delete from users where char_length(username) = 5;
select * from users;
rollback;

begin;
insert into videos (channel_id, title, description, uploaded_at) values (5, 'My new video', 'nothing to see here', now());
update videos set description = 'new description' where id = 9;
select channel_id, title, description, uploaded_at from videos;
delete from videos where extract(month from uploaded_at) != 1;
select * from videos;
rollback;

begin;
insert into playlists (id, name, author_id, created_at) values (6, 'Best videos', 4, now());
insert into playlist_video (playlist_id, video_id) values (6, 1), (6, 2), (6, 3);
update users set username = 'not dave' where id = 4;
delete from playlists where id = 2;
select p.id, p.name, p.author_id, u.username as author_name from playlists p join users u on p.author_id = u.id;
rollback;

begin;
insert into views (user_id, video_id, watched_at) values (6, 2, now());
insert into comments (id, user_id, video_id, comment_text, commented_at) values (11, 6, 2, 'youre bst work yet!', now());
update comments set comment_text = 'your best work yet!', commented_at = now() where id = 11;
delete from comments where id = 10;
select * from comments where id % 2 = 1;
rollback;