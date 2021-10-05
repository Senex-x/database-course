create table twitter.user_subscription
(
    subscriber_user_id integer
        constraint subscription_user_id_fk
            references twitter."user",
    host_user_id       integer
        constraint subscription_user_id_fk_2
            references twitter."user"
);

INSERT INTO twitter."user"
(id, first_name, last_name, username, password, birth_date, gender, user_pic)
VALUES (DEFAULT, 'Alex', 'Mann', 'AlemaNN', 'sdjkgskd', '2000-04-09', null, null);

INSERT INTO twitter.user_subscription
    (subscriber_user_id, host_user_id)
VALUES (2, 1);

INSERT INTO twitter.tweet
    (id, user_id, text, photo, publish_date, replies_to, retweets)
VALUES (DEFAULT, 2, 'Sample tweet with a hashtag', null, '2021-10-01', null, null);

INSERT INTO twitter.hashtag
    (id, text)
VALUES (DEFAULT, 'first_tweet');

INSERT INTO twitter.tweet_hashtag
    (id, tweet_id, hashtag_id)
VALUES (DEFAULT, 6, 1);

INSERT INTO twitter.user_like
    (id, user_id, tweet_id)
VALUES (DEFAULT, 1, 6);

