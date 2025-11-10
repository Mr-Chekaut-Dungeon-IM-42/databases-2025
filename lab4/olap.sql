-- Sum of views of all videos in a playlist.
select
	p.id as playlist_id,
	p.name as playlist_name,
	u.username as playlist_author,
	count(*) as playlist_views
from
	playlists p
join users u on
	p.author_id = u.id
join playlist_video pv on
	p.id = pv.playlist_id
join videos vd on
	pv.video_id = vd.id
join views vw on vd.id = vw.video_id
group by p.id, u.username;

-- Number of user's comments with some random HAVING clause
select
	u.username,
	count(*) as comments
from
	comments c
join users u on
	user_id = u.id
group by
	c.user_id,
	u.username
having
	count(*) > 1
order by
	username asc;

-- Channel viewcount statistics among all its videos
with video_views (name, author, title, views) as (
	select
		c.name,
		u.username as author,
		v.title,
		count(*) as views
	from
		views vw
	join videos v on
		vw.video_id = v.id
	join channels c on
		v.channel_id = c.id
	join users u on
		c.owner_id = u.id
	group by
		v.id, c.name, u.username
)
select
	name,
	author,
	avg("views") as avg_views,
	min("views") as min_views,
	max("views") as max_views
from
	video_views
group by
	name, author;