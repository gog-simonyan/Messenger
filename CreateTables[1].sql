CREATE DATABASE Messenger;
USE Messenger;

CREATE TABLE User (
  username varchar(255),
  status VARCHAR(10) NOT NULL CHECK (status IN('online', 'offline'
)),
  PRIMARY KEY (username)


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

INSERT INTO User VALUES('Gohar', 'online');
INSERT INTO User VALUES('Elen', 'online');

INSERT INTO UserGroup VALUES('Frends');

INSERT INTO Belongs VALUES('Gohar', 'Frends');
INSERT INTO Belongs VALUES('Elen', 'Frends');

INSERT INTO Message VALUES(1, 'hi', '2021-01-18 01:35:24', 'Gohar', 'Elen', NULL);
INSERT INTO Message VALUES(2, 'hello', '2021-01-18 00:36:24', 'Gohat', NULL, 'Frend');
