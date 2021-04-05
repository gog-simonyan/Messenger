CREATE DATABASE Messenger;
USE Messenger;

CREATE TABLE User (
  username varchar(255),
  status VARCHAR(10) NOT NULL CHECK (status IN('online', 'offline', 'away')),
  PRIMARY KEY (username)
);

CREATE TABLE UserGroup (
  group_name varchar(255),
  PRIMARY KEY (group_name)
);

CREATE TABLE Message (
  id int,
  content varchar(255),
  send_time DateTime,
  sender_username varchar(255),
  receiver_username varchar(255),
  receiver_group_name varchar(255),
  PRIMARY KEY (id),
  FOREIGN KEY (sender_username) REFERENCES User(username),
  FOREIGN KEY (receiver_username) REFERENCES User(username),
  FOREIGN KEY (receiver_group_name) REFERENCES UserGroup(group_name),
  CHECK (receiver_username IS NULL And receiver_group_name IS NOT NULL OR 
         receiver_username IS NOT NULL And receiver_group_name IS NULL)
);

CREATE TABLE Belongs (
  username varchar(255),
  group_name varchar(255),
  PRIMARY KEY (username, group_name),
  FOREIGN KEY (username) REFERENCES User(username),
  FOREIGN KEY (group_name) REFERENCES UserGroup(group_name)
);

INSERT INTO User VALUES('Hrach', 'online');
INSERT INTO User VALUES('Hasmik', 'online');

INSERT INTO UserGroup VALUES('Family');

INSERT INTO Belongs VALUES('Hrach', 'Family');
INSERT INTO Belongs VALUES('Hasmik', 'Family');

INSERT INTO Message VALUES(1, 'hello', '2021-02-28 00:38:54', 'Hrach', 'Hasmik', NULL);
INSERT INTO Message VALUES(2, 'hello everyone', '2021-02-28 00:39:54', 'Hrach', NULL, 'Family');
