CREATE TABLE IF NOT EXISTS users (
    id     SERIAL PRIMARY KEY,
    username    VARCHAR(32) NOT NULL UNIQUE,
    email       VARCHAR(64) NOT NULL UNIQUE,
    created_at  DATE NOT NULL
);

CREATE TABLE channels (
    id           SERIAL PRIMARY KEY,
    name         VARCHAR(32) NOT NULL,
    created_at   DATE NOT NULL,
    owner_id     SERIAL NOT NULL REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE videos (
    id           SERIAL PRIMARY KEY,
    title        TEXT NOT NULL CHECK (LENGTH(title) <= 128),
    description  TEXT CHECK (LENGTH(description) <= 256),
    uploaded_at  DATE NOT NULL DEFAULT NOW(),
    channel_id   SERIAL NOT NULL REFERENCES channels(id) ON DELETE CASCADE
);

CREATE TABLE comments (
    id            SERIAL PRIMARY KEY,
    comment_text  TEXT NOT NULL CHECK (LENGTH(comment_text) <= 2048),
    commented_at  DATE NOT NULL DEFAULT NOW(),
    user_id       SERIAL NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    video_id      SERIAL NOT NULL REFERENCES videos(id) ON DELETE CASCADE
);

CREATE TABLE playlists (
    id          SERIAL PRIMARY KEY,
    name        VARCHAR(64) NOT NULL,
    created_at  DATE NOT NULL DEFAULT NOW(),
    author_id   SERIAL NOT NULL REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE playlist_video (
    playlist_id SERIAL NOT NULL REFERENCES playlists(id) ON DELETE CASCADE,
    video_id    SERIAL NOT NULL REFERENCES videos(id) ON DELETE CASCADE,
    PRIMARY KEY (playlist_id, video_id)
);

CREATE TABLE subscription (
    user_id    SERIAL NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    channel_id SERIAL NOT NULL REFERENCES channels(id) ON DELETE CASCADE,
    PRIMARY KEY (user_id, channel_id)
);

CREATE TABLE views (
    id          SERIAL PRIMARY KEY,
    watched_at  DATE NOT NULL DEFAULT NOW(),
    user_id     SERIAL NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    video_id    SERIAL NOT NULL REFERENCES videos(id) ON DELETE CASCADE
);
