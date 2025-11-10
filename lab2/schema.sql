CREATE TABLE IF NOT EXISTS users (
    id          SERIAL PRIMARY KEY,
    username    VARCHAR(32) NOT NULL UNIQUE,
    email       VARCHAR(64) NOT NULL UNIQUE,
    created_at  DATE NOT NULL
);

INSERT INTO users (username, email, created_at) VALUES
('alice', 'alice@example.com', '2024-01-12'),
('bob', 'bob@example.com', '2024-01-14'),
('charlie', 'charlie@example.com', '2024-02-01'),
('dave', 'dave@example.com', '2024-02-06'),
('eve', 'eve@example.com', '2024-03-01'),
('frank', 'frank@example.com', '2024-03-03'),
('grace', 'grace@example.com', '2024-03-10');

CREATE TABLE channels (
    id           SERIAL PRIMARY KEY,
    name         VARCHAR(32) NOT NULL,
    created_at   DATE NOT NULL,
    owner_id     SERIAL NOT NULL REFERENCES users(id) ON DELETE CASCADE
);

INSERT INTO channels (name, created_at, owner_id) VALUES
('AliceChannel', '2024-01-13', 1),
('BobTV', '2024-01-16', 2),
('GamingWithCharlie', '2024-02-02', 3),
('DavePlays', '2024-02-06', 4),
('EveLearns', '2024-03-01', 5),
('FrankTalks', '2024-03-04', 6);

CREATE TABLE videos (
    id           SERIAL PRIMARY KEY,
    title        TEXT NOT NULL CHECK (LENGTH(title) <= 128),
    description  TEXT CHECK (LENGTH(description) <= 256),
    uploaded_at  DATE NOT NULL DEFAULT NOW(),
    channel_id   SERIAL NOT NULL REFERENCES channels(id) ON DELETE CASCADE
);

INSERT INTO videos (title, description, uploaded_at, channel_id) VALUES
('Hello World!', 'My first video.', '2024-01-13', 1),
('Top 10 Coding Tips', 'Coding tips for 2024.', '2024-01-16', 2),
('Epic Game Review', NULL, '2024-02-03', 3),
('Daily Vlog', 'A day in my life.', '2024-01-20', 1),
('Dave’s Adventure', 'Hiking with Dave.', '2024-02-07', 4),
('Math for Beginners', 'Starting with the basics.', '2024-03-02', 5),
('How to Public Speak', 'Overcome fear of stage.', '2024-03-05', 6),
('Unboxing New Tech', '', '2024-03-08', 2),
('Silent Walkthrough', NULL, '2024-03-10', 3);

CREATE TABLE comments (
    id            SERIAL PRIMARY KEY,
    comment_text  TEXT NOT NULL CHECK (LENGTH(comment_text) <= 2048),
    commented_at  DATE NOT NULL DEFAULT NOW(),
    user_id       SERIAL NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    video_id      SERIAL NOT NULL REFERENCES videos(id) ON DELETE CASCADE
);

INSERT INTO comments (comment_text, commented_at, user_id, video_id) VALUES
('Nice video!', '2024-01-14', 2, 1),
('Very helpful, thanks!', '2024-01-17', 1, 2),
('Subscribed!', '2024-02-04', 1, 3),
('Great review', '2024-02-05', 2, 3),
('Loved the scenery!', '2024-02-08', 1, 5),
('Super helpful', '2024-03-03', 3, 6),
('Can you make more of these?', '2024-03-06', 4, 7),
('Nice gadgets!', '2024-03-09', 5, 8),
('No talking, bold move!', '2024-03-11', 2, 9),
('Excellent tips.', '2024-03-05', 6, 7);

CREATE TABLE playlists (
    id          SERIAL PRIMARY KEY,
    name        VARCHAR(64) NOT NULL,
    created_at  DATE NOT NULL DEFAULT NOW(),
    author_id   SERIAL NOT NULL REFERENCES users(id) ON DELETE CASCADE
);

INSERT INTO playlists (name, created_at, author_id) VALUES
('Favorite Tutorials', '2024-01-18', 1),
('Watch Later', '2024-01-19', 2),
('Next Up', '2024-03-07', 3),
('Educational', '2024-03-02', 5),
('To Rewatch', '2024-03-10', 2);

CREATE TABLE playlist_video (
    playlist_id SERIAL NOT NULL REFERENCES playlists(id) ON DELETE CASCADE,
    video_id    SERIAL NOT NULL REFERENCES videos(id) ON DELETE CASCADE,
    PRIMARY KEY (playlist_id, video_id)
);

INSERT INTO playlist_video (playlist_id, video_id) VALUES
(1, 2),
(1, 1),
(2, 3),
(2, 4),
(3, 7),
(3, 8),
(4, 6),
(4, 2),
(5, 1),
(5, 9);

CREATE TABLE subscription (
    user_id     SERIAL NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    channel_id  SERIAL NOT NULL REFERENCES channels(id) ON DELETE CASCADE,
    PRIMARY KEY (user_id, channel_id)
);

INSERT INTO subscription (user_id, channel_id) VALUES
(1, 2),
(1, 3),
(2, 1),
(3, 1),
(4, 1),
(5, 2),
(6, 4),
(2, 5),
(3, 6),
(1, 6);

CREATE TABLE views (
    id          SERIAL PRIMARY KEY,
    watched_at  DATE NOT NULL DEFAULT NOW(),
    user_id     SERIAL NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    video_id    SERIAL NOT NULL REFERENCES videos(id) ON DELETE CASCADE
);

INSERT INTO views (watched_at, user_id, video_id) VALUES
('2024-01-14', 2, 1),
('2024-01-17', 1, 2),
('2024-02-04', 1, 3),
('2024-02-05', 2, 3),
('2024-01-20', 3, 4),
('2024-02-08', 1, 5),
('2024-03-04', 3, 6),
('2024-03-06', 4, 7),
('2024-03-09', 5, 8),
('2024-03-11', 2, 9),
('2024-03-07', 2, 4),
('2024-03-10', 6, 8),
('2024-03-02', 4, 6);
