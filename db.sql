CREATE DATABASE IF NOT EXISTS vrmeeting_apis_development;
CREATE DATABASE IF NOT EXISTS vrmeeting_apis_test;

DROP TABLE IF EXISTS vrmeeting_apis_test.user_files;
DROP TABLE IF EXISTS vrmeeting_apis_test.meetings;
DROP TABLE IF EXISTS vrmeeting_apis_test.file_lists;
DROP TABLE IF EXISTS vrmeeting_apis_test.users;

DROP TABLE IF EXISTS vrmeeting_apis_development.user_files;
DROP TABLE IF EXISTS vrmeeting_apis_development.meetings;
DROP TABLE IF EXISTS vrmeeting_apis_development.file_lists;
DROP TABLE IF EXISTS vrmeeting_apis_development.users;


CREATE TABLE vrmeeting_apis_test.users(
    Uid INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    Email VARCHAR(80) UNIQUE KEY NOT NULL,
    password_digest VARCHAR(255) DEFAULT NULL
);

CREATE TABLE vrmeeting_apis_development.users(
    Uid INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    Email VARCHAR(80) UNIQUE KEY NOT NULL,
    password_digest VARCHAR(255) DEFAULT NULL
);

CREATE TABLE vrmeeting_apis_test.user_files(
    Uid int PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(15) NOT NULL,
    SurName VARCHAR(20) NOT NULL,
    Company VARCHAR(50) NOT NULL,
    JobTitle VARCHAR(30) NOT NULL,
    WorkEmail VARCHAR(100) DEFAULT NULL,
    PhoneNum VARCHAR(11) DEFAULT NULL,
    Question1 VARCHAR(50) NOT NULL,
    Question2 VARCHAR(50) NOT NULL,
    Question3 VARCHAR(50) NOT NULL,
    Answer1 VARCHAR(20) NOT NULL,
    Answer2 VARCHAR(20) NOT NULL,
    Answer3 VARCHAR(20) NOT NULL,
    AvatarID int NOT NULL,
    FOREIGN KEY (Uid) REFERENCES users(Uid)
    ON UPDATE RESTRICT ON DELETE CASCADE
);

CREATE TABLE vrmeeting_apis_development.user_files(
    Uid int PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(15) NOT NULL,
    SurName VARCHAR(20) NOT NULL,
    Company VARCHAR(50) NOT NULL,
    JobTitle VARCHAR(30) NOT NULL,
    WorkEmail VARCHAR(100) DEFAULT NULL,
    PhoneNum VARCHAR(11) DEFAULT NULL,
    Question1 VARCHAR(50) NOT NULL,
    Question2 VARCHAR(50) NOT NULL,
    Question3 VARCHAR(50) NOT NULL,
    Answer1 VARCHAR(20) NOT NULL,
    Answer2 VARCHAR(20) NOT NULL,
    Answer3 VARCHAR(20) NOT NULL,
    AvatarID int NOT NULL,
    FOREIGN KEY (Uid) REFERENCES users(Uid)
    ON UPDATE RESTRICT ON DELETE CASCADE
);

CREATE TABLE vrmeeting_apis_test.meetings(
  Mid INT AUTO_INCREMENT NOT NULL,
  MeetingName VARCHAR(40) UNIQUE KEY NOT NULL,
  MeetingDescption VARCHAR(255) DEFAULT NULL,
  DoM VARCHAR(12) DEFAULT NULL,
  ToM VARCHAR(7) DEFAULT NULL,
  MeetingCode VARCHAR(40) NOT NULL,
  Uid int NOT NULL,
  PRIMARY KEY (Mid),
  FOREIGN KEY (Uid) REFERENCES users(Uid)
  ON UPDATE RESTRICT ON DELETE CASCADE
);

CREATE TABLE vrmeeting_apis_development.meetings(
  Mid INT AUTO_INCREMENT NOT NULL,
  MeetingName VARCHAR(40) UNIQUE KEY NOT NULL,
  MeetingDescption VARCHAR(255) DEFAULT NULL,
  DoM VARCHAR(12) DEFAULT NULL,
  ToM VARCHAR(7) DEFAULT NULL,
  MeetingCode VARCHAR(40) NOT NULL,
  Uid int NOT NULL,
  PRIMARY KEY (Mid),
  FOREIGN KEY (Uid) REFERENCES users(Uid)
  ON UPDATE RESTRICT ON DELETE CASCADE
);

CREATE TABLE vrmeeting_apis_test.file_lists(
  Mid Varchar(30) NOT NULL primary key,
  file text null
);

CREATE TABLE vrmeeting_apis_development.file_lists(
  Mid Varchar(30) NOT NULL primary key,
  file text null
);
