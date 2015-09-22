CREATE TABLE STATE (
  state_id SERIAL  NOT NULL ,
  title TEXT    ,
  description TEXT      ,
PRIMARY KEY(state_id));




CREATE TABLE MEDIAS_TYPE (
  type_id SERIAL  NOT NULL ,
  media_type TEXT      ,
PRIMARY KEY(type_id));




CREATE TABLE ORNAMENTS (
  ornament_id SERIAL  NOT NULL ,
  name TEXT    ,
  description TEXT      ,
PRIMARY KEY(ornament_id));




CREATE TABLE USERS (
  user_id SERIAL  NOT NULL ,
  pseudo TEXT    ,
  user_password TEXT    ,
  state TEXT      ,
PRIMARY KEY(user_id));




CREATE TABLE TITLES (
  title_id SERIAL  NOT NULL ,
  name TEXT    ,
  description TEXT      ,
PRIMARY KEY(title_id));




CREATE TABLE SUCCESS_SUPERCATEGORY (
  supercategory_id SERIAL  NOT NULL ,
  title TEXT    ,
  description TEXT    ,
  nb_category INTEGER    ,
  state TEXT      ,
PRIMARY KEY(supercategory_id));




CREATE TABLE SUBSCRIPTION (
  subscription_id INTEGER   NOT NULL ,
  date SERIAL  NOT NULL ,
  subscriber_id INTEGER   NOT NULL   ,
PRIMARY KEY(subscription_id)  ,
  FOREIGN KEY(subscriber_id)
    REFERENCES USERS(user_id));


CREATE INDEX SUBSCRIPTION_FK_INDEX ON SUBSCRIPTION (subscriber_id);


CREATE INDEX IFK_subscribe ON SUBSCRIPTION (subscriber_id);


CREATE TABLE STATS (
  stats_id SERIAL  NOT NULL ,
  user_id INTEGER   NOT NULL ,
  success_points INTEGER    ,
  nb_success_done INTEGER      ,
PRIMARY KEY(stats_id)  ,
  FOREIGN KEY(user_id)
    REFERENCES USERS(user_id));


CREATE INDEX STATS_index1560 ON STATS (user_id);


CREATE INDEX IFK_have ON STATS (user_id);


CREATE TABLE SUCCESS_PROGRESS (
  success_progress_id SERIAL  NOT NULL ,
  user_id INTEGER   NOT NULL ,
  state TEXT    ,
  date DATE    ,
  repetitions_done INTEGER      ,
PRIMARY KEY(success_progress_id)  ,
  FOREIGN KEY(user_id)
    REFERENCES USERS(user_id));


CREATE INDEX SUCCESS_PROGRESS_index1546 ON SUCCESS_PROGRESS (user_id);


CREATE INDEX IFK_send ON SUCCESS_PROGRESS (user_id);


CREATE TABLE SUCCESS_CATEGORY (
  category_id SERIAL  NOT NULL ,
  supercategory_id INTEGER   NOT NULL ,
  title TEXT    ,
  description TEXT    ,
  nb_subcategory INTEGER    ,
  state TEXT      ,
PRIMARY KEY(category_id)  ,
  FOREIGN KEY(supercategory_id)
    REFERENCES SUCCESS_SUPERCATEGORY(supercategory_id));


CREATE INDEX SUCCESS_CATEGORY_index1551 ON SUCCESS_CATEGORY (supercategory_id);


CREATE INDEX IFK_have ON SUCCESS_CATEGORY (supercategory_id);


CREATE TABLE CHANNEL (
  channel_id SERIAL  NOT NULL ,
  user_id INTEGER   NOT NULL ,
  ornement (a faire) FK INTEGER    ,
  titre (a faire) FK INTEGER    ,
  avatar TEXT      ,
PRIMARY KEY(channel_id)  ,
  FOREIGN KEY(user_id)
    REFERENCES USERS(user_id));


CREATE INDEX CHANNEL_index1562 ON CHANNEL (user_id);


CREATE INDEX IFK_have ON CHANNEL (user_id);


CREATE TABLE PROPOSITION (
  proposition_id SERIAL  NOT NULL ,
  user_id INTEGER   NOT NULL ,
  title TEXT    ,
  description TEXT      ,
PRIMARY KEY(proposition_id),
  FOREIGN KEY(user_id)
    REFERENCES USERS(user_id));


CREATE INDEX IFK_send ON PROPOSITION (user_id);


CREATE TABLE FRIENDS (
  date SERIAL  NOT NULL ,
  user_sending_id INTEGER   NOT NULL ,
  user_receiving_id INTEGER   NOT NULL ,
  state TEXT      ,
PRIMARY KEY(date)    ,
  FOREIGN KEY(user_receiving_id)
    REFERENCES USERS(user_id),
  FOREIGN KEY(user_sending_id)
    REFERENCES USERS(user_id));


CREATE INDEX FRIENDS_index1557 ON FRIENDS (user_receiving_id);
CREATE INDEX FRIENDS_index1558 ON FRIENDS (user_sending_id);


CREATE INDEX IFK_receive/accept ON FRIENDS (user_receiving_id);
CREATE INDEX IFK_send/have ON FRIENDS (user_sending_id);


CREATE TABLE NOTIFICATIONS (
  notification_id INTEGER   NOT NULL ,
  date SERIAL  NOT NULL ,
  user_receiving_id INTEGER   NOT NULL ,
  user_sending_id INTEGER   NOT NULL ,
  content TEXT    ,
  path TEXT    ,
  read_state BOOL      ,
PRIMARY KEY(notification_id)  ,
  FOREIGN KEY(user_sending_id)
    REFERENCES USERS(user_id),
  FOREIGN KEY(user_receiving_id)
    REFERENCES USERS(user_id));


CREATE INDEX NOTIFICATIONS_index1543 ON NOTIFICATIONS (user_receiving_id, user_sending_id);


CREATE INDEX IFK_send ON NOTIFICATIONS (user_sending_id);
CREATE INDEX IFK_receive ON NOTIFICATIONS (user_receiving_id);


CREATE TABLE PROFILES (
  profile_id SERIAL  NOT NULL ,
  ornament_id INTEGER   NOT NULL ,
  title_id INTEGER   NOT NULL ,
  user_id INTEGER   NOT NULL ,
  city VARCHAR(45)    ,
  birthdate DATE    ,
  email TEXT      ,
PRIMARY KEY(profile_id)  ,
  FOREIGN KEY(user_id)
    REFERENCES USERS(user_id),
  FOREIGN KEY(title_id)
    REFERENCES TITLES(title_id),
  FOREIGN KEY(ornament_id)
    REFERENCES ORNAMENTS(ornament_id));


CREATE INDEX PROFILES_index1555 ON PROFILES (user_id);


CREATE INDEX IFK_have ON PROFILES (user_id);
CREATE INDEX IFK_have ON PROFILES (title_id);
CREATE INDEX IFK_have ON PROFILES (ornament_id);


CREATE TABLE SUCCESS_SUBCATEGORY (
  subcategory_id SERIAL  NOT NULL ,
  category_id INTEGER   NOT NULL ,
  title TEXT    ,
  description TEXT    ,
  nb_success INTEGER    ,
  state TEXT      ,
PRIMARY KEY(subcategory_id)  ,
  FOREIGN KEY(category_id)
    REFERENCES SUCCESS_CATEGORY(category_id));


CREATE INDEX SUCCESS_SUBCATEGORY_index1553 ON SUCCESS_SUBCATEGORY (category_id);


CREATE INDEX IFK_have ON SUCCESS_SUBCATEGORY (category_id);


CREATE TABLE POST (
  post_id SERIAL  NOT NULL ,
  channel_id INTEGER   NOT NULL ,
  date DATE    ,
  content TEXT      ,
PRIMARY KEY(post_id)  ,
  FOREIGN KEY(channel_id)
    REFERENCES CHANNEL(channel_id));


CREATE INDEX POST_index1564 ON POST (channel_id);


CREATE INDEX IFK_send ON POST (channel_id);


CREATE TABLE SUCCESS_LIST (
  success_id SERIAL  NOT NULL ,
  title_id INTEGER   NOT NULL ,
  subcategory_id INTEGER   NOT NULL ,
  ornament_id INTEGER   NOT NULL ,
  title TEXT    ,
  description TEXT    ,
  nb_points INTEGER    ,
  type_2 TEXT    ,
  repetitions INTEGER      ,
PRIMARY KEY(success_id)    ,
  FOREIGN KEY(subcategory_id)
    REFERENCES SUCCESS_SUBCATEGORY(subcategory_id),
  FOREIGN KEY(ornament_id)
    REFERENCES ORNAMENTS(ornament_id),
  FOREIGN KEY(title_id)
    REFERENCES TITLES(title_id));


CREATE INDEX SUCCESS_LIST_index1548 ON SUCCESS_LIST (title_id);
CREATE INDEX SUCCESS_LIST_index1549 ON SUCCESS_LIST (subcategory_id);


CREATE INDEX IFK_have ON SUCCESS_LIST (subcategory_id);
CREATE INDEX IFK_have ON SUCCESS_LIST (ornament_id);
CREATE INDEX IFK_have ON SUCCESS_LIST (title_id);


CREATE TABLE MEDIAS (
  media_id SERIAL  NOT NULL ,
  type_id INTEGER   NOT NULL ,
  success_progress_id INTEGER   NOT NULL ,
  success_id INTEGER   NOT NULL ,
  path TEXT    ,
  description TEXT    ,
  title TEXT    ,
  nb_views INTEGER    ,
  state TEXT      ,
PRIMARY KEY(media_id)  ,
  FOREIGN KEY(success_id)
    REFERENCES SUCCESS_LIST(success_id),
  FOREIGN KEY(success_progress_id)
    REFERENCES SUCCESS_PROGRESS(success_progress_id),
  FOREIGN KEY(type_id)
    REFERENCES MEDIAS_TYPE(type_id));


CREATE INDEX MEDIAS_FK ON MEDIAS (type_id, success_id);


CREATE INDEX IFK_have ON MEDIAS (success_id);
CREATE INDEX IFK_have ON MEDIAS (success_progress_id);
CREATE INDEX IFK_have ON MEDIAS (type_id);


CREATE TABLE MEDIAS_COMMENTS (
  comment_id SERIAL  NOT NULL ,
  state_id INTEGER   NOT NULL ,
  comment_parent_id INTEGER   NOT NULL ,
  user_id INTEGER   NOT NULL ,
  media_id INTEGER   NOT NULL ,
  date DATE    ,
  content TEXT    ,
  rating INTEGER      ,
PRIMARY KEY(comment_id)    ,
  FOREIGN KEY(media_id)
    REFERENCES MEDIAS(media_id),
  FOREIGN KEY(user_id)
    REFERENCES USERS(user_id),
  FOREIGN KEY(comment_parent_id)
    REFERENCES MEDIAS_COMMENTS(comment_id),
  FOREIGN KEY(state_id)
    REFERENCES STATE(state_id));


CREATE INDEX MEDIAS_COMMENTS_FK ON MEDIAS_COMMENTS (user_id, media_id);
CREATE INDEX MEDIAS_COMMENTS_PARENTS_INDEX ON MEDIAS_COMMENTS (comment_parent_id, rating, date);


CREATE INDEX IFK_have ON MEDIAS_COMMENTS (media_id);
CREATE INDEX IFK_send ON MEDIAS_COMMENTS (user_id);
CREATE INDEX IFK_father of ON MEDIAS_COMMENTS (comment_parent_id);
CREATE INDEX IFK_have ON MEDIAS_COMMENTS (state_id);



