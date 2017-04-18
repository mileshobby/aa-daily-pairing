DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname TEXT NOT NULL,
  lname TEXT NOT NULL
);


DROP TABLE IF EXISTS questions;

CREATE TABLE questions(
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS question_follows;
--join table
CREATE TABLE question_follows(
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id)

);

DROP TABLE IF EXISTS replies;

CREATE TABLE replies(
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  parent_id INTEGER,
  body TEXT NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS question_likes;

CREATE TABLE question_likes(
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO
  users (fname, lname)
VALUES
  ('Arthur', 'Miller'),
  ('Eugene1', 'O''Neill1'),
  ('Arthur2', 'Miller2'),
  ('Eugene3', 'O''Neill3'),
  ('Arthur4', 'Miller4'),
  ('Eugene5', 'O''Neill5'),
  ('Arthur6', 'Miller6'),
  ('Eugene7', 'O''Neill7');

INSERT INTO
  questions (title, body, user_id)
VALUES
  ('title', 'How?', (SELECT id FROM users WHERE fname = 'Arthur')),
  ('title2', 'Why?', (SELECT id FROM users WHERE fname = 'Eugene1')),
  ('title3', 'HowHow?', (SELECT id FROM users WHERE fname = 'Arthur')),
  ('title4', 'Where?', (SELECT id FROM users WHERE fname = 'Arthur'));

INSERT INTO
  replies (body, user_id, question_id, parent_id)
VALUES
  ('reply1', 1, 1, NULL),
  ('reply2', 2, 1, 1),
  ('reply3', 4, 2, NULL),
  ('reply4', 1, 1, 2),
  ('reply5', 3, 2, 1),
  ('reply6', 4, 2, 2),
  ('reply7', 4, 1, 3),
  ('reply8', 6, 2, 3),
  ('reply9', 5, 2, 4);

INSERT INTO
  question_follows (question_id, user_id)
VALUES
  (1, 2),
  (2, 2),
  (3, 5),
  (4, 2),
  (1, 2),
  (1, 3),
  (1, 8),
  (4, 7),
  (3, 6),
  (2, 8),
  (4, 8);

INSERT INTO
  question_likes (question_id, user_id)
VALUES
  (1, 2),
  (2, 2),
  (3, 5),
  (4, 2),
  (1, 2),
  (1, 3),
  (1, 8),
  (4, 7),
  (3, 6),
  (2, 8),
  (4, 8);
