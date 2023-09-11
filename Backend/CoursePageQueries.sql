CREATE TABLE USER_INFO(
user_id NUMBER NOT NULL,
auth_type VARCHAR(200) ,
username VARCHAR(200) UNIQUE,
hassed_password VARCHAR2(250),
name VARCHAR(50),
email VARCHAR(200),
birth_date VARCHAR(200),
location VARCHAR2(250),
institution VARCHAR2(250),
lvl NUMBER,
term NUMBER,
CONSTRAINT pk_user1 PRIMARY KEY(user_id)
);



CREATE TABLE REQUESTED_COURSE(
request_id NUMBER NOT NULL,
user_id NUMBER,
request_type VARCHAR(200) ,
title VARCHAR(200),
description VARCHAR2(250),
request_date VARCHAR2(250),
status NUMBER,
CONSTRAINT pk_requestedcourse1 PRIMARY KEY(request_id),
CONSTRAINT fk_requestedcourse1 FOREIGN KEY (user_id)
REFERENCES	USER_INFO(user_id)	ON DELETE CASCADE
);





CREATE TABLE COURSE(
courseid NUMBER NOT NULL,
author_id NUMBER NOT NULL,
title VARCHAR(200) ,
description VARCHAR(200),
is_live NUMBER,
total_contents NUMBER,
block_count NUMBER,
avg_duration NUMBER,
intro BLOB,
CONSTRAINT pk_course1 PRIMARY KEY(courseid),
CONSTRAINT fk_course1 FOREIGN KEY (author_id)
REFERENCES	USER_INFO(user_id)	ON DELETE CASCADE
);

CREATE TABLE BLOCK(
block_id NUMBER NOT NULL,
course_id NUMBER ,
title VARCHAR(200) ,
body VARCHAR2(2000),
serial NUMBER,
lec_count NUMBER,
CONSTRAINT pk_block1 PRIMARY KEY(block_id),
CONSTRAINT fk_block2 FOREIGN KEY (course_id)
REFERENCES	COURSE(courseid)	ON DELETE CASCADE
);


CREATE TABLE LECTURE(
lecture_id NUMBER NOT NULL,
block_id NUMBER ,
title VARCHAR(200) ,
body VARCHAR(200),
is_live NUMBER,
serial NUMBER,
n_views NUMBER,
lesson_count NUMBER,
CONSTRAINT pk_lecture1 PRIMARY KEY(lecture_id),
CONSTRAINT fk_lecture2 FOREIGN KEY (block_id)
REFERENCES	BLOCK(block_id)	ON DELETE CASCADE
);

CREATE TABLE LESSON(
lesson_id NUMBER NOT NULL,
lecture_id NUMBER ,
title VARCHAR(200) ,
body VARCHAR(200),
is_live NUMBER,
serial NUMBER,
n_views NUMBER,
contents NUMBER,
CONSTRAINT pk_lesson1 PRIMARY KEY(lesson_id),
CONSTRAINT fk_lesson2 FOREIGN KEY (lecture_id)
REFERENCES	LECTURE(lecture_id)	ON DELETE CASCADE
);

CREATE TABLE PDF(
pdf_id NUMBER NOT NULL,
lesson_id NUMBER ,
title VARCHAR(200) ,
content BLOB,
is_live NUMBER,
serial NUMBER,
n_views NUMBER,
CONSTRAINT pk_pdf1 PRIMARY KEY(pdf_id),
CONSTRAINT fk_pdf2 FOREIGN KEY (lesson_id)
REFERENCES	LESSON(lesson_id)	ON DELETE CASCADE
);




CREATE TABLE VIDEO(
video_id NUMBER NOT NULL,
lesson_id NUMBER ,
title VARCHAR(200) ,
content BLOB,
is_live NUMBER,
serial NUMBER,
n_views NUMBER,
CONSTRAINT pk_video1 PRIMARY KEY(video_id),
CONSTRAINT fk_video2 FOREIGN KEY (lesson_id)
REFERENCES	LESSON(lesson_id)	ON DELETE CASCADE
);





CREATE TABLE COURSE_TAKEN(
courseid NUMBER NOT NULL,
userid NUMBER NOT NULL,
last_access_date VARCHAR(200) ,
enrollment_date VARCHAR(200),
completed_contents NUMBER,
lastviewed_block NUMBER,
lastviewed_lecture NUMBER,
lastviewed_lesson NUMBER,
CONSTRAINT pk_coursetaken1 PRIMARY KEY(userid,courseid),
CONSTRAINT fk_coursetaken1 FOREIGN KEY (userid)
REFERENCES	USER_INFO(user_id)	ON DELETE CASCADE,
CONSTRAINT fk_coursetaken2 FOREIGN KEY (courseid)
REFERENCES	COURSE(courseid)	ON DELETE CASCADE,

CONSTRAINT fk_coursetaken3 FOREIGN KEY (lastviewed_block)
REFERENCES	BLOCK(block_id)	ON DELETE CASCADE,
CONSTRAINT fk_coursetaken4 FOREIGN KEY (lastviewed_lecture)
REFERENCES	LECTURE(lecture_id)	ON DELETE CASCADE,
CONSTRAINT fk_coursetaken5 FOREIGN KEY (lastviewed_lesson)
REFERENCES	LESSON(lesson_id)	ON DELETE CASCADE
);





CREATE TABLE TAG(
tag_id NUMBER NOT NULL,
tag_name VARCHAR(200),
CONSTRAINT pk_tagid1 PRIMARY KEY(tag_id)
);




CREATE TABLE TAG_COURSE(
tag_id NUMBER NOT NULL,
course_id NUMBER NOT NULL,
weight NUMBER, 
CONSTRAINT pk_tagcourse1 PRIMARY KEY(tag_id ,course_id),
CONSTRAINT fk_tagcourse1 FOREIGN KEY (tag_id)
REFERENCES	TAG(tag_id)	ON DELETE CASCADE,
CONSTRAINT fk_tagcourse2 FOREIGN KEY (course_id)
REFERENCES	COURSE(courseid)	ON DELETE CASCADE
);



CREATE TABLE TAG_LECTURE(
tag_id NUMBER NOT NULL,
lecture_id NUMBER NOT NULL,
weight NUMBER, 
CONSTRAINT pk_taglecture1 PRIMARY KEY(tag_id ,lecture_id),
CONSTRAINT fk_taglecture1 FOREIGN KEY (tag_id)
REFERENCES	TAG(tag_id)	ON DELETE CASCADE,
CONSTRAINT fk_taglecture2 FOREIGN KEY (lecture_id)
REFERENCES	LECTURE(lecture_id)	ON DELETE CASCADE
);

CREATE TABLE USER_EXPERTISE(
user_id NUMBER NOT NULL,
tag_id NUMBER NOT NULL,
expertise_score NUMBER, 
CONSTRAINT pk_userexpertise1 PRIMARY KEY(user_id ,tag_id),
CONSTRAINT fk_userexpertise1 FOREIGN KEY (tag_id)
REFERENCES	TAG(tag_id)	ON DELETE CASCADE,
CONSTRAINT fk_userexpertise2 FOREIGN KEY (user_id)
REFERENCES	USER_INFO(user_id)	ON DELETE CASCADE
);

CREATE TABLE CORRELATION_MATRIX(
tag_id_from NUMBER NOT NULL,
tag_id_to NUMBER NOT NULL,
expertise_score NUMBER, 
CONSTRAINT pk_correlationmatrix1 PRIMARY KEY(tag_id_from ,tag_id_to),
CONSTRAINT fk_correlationmatrix1 FOREIGN KEY (tag_id_from)
REFERENCES	TAG(tag_id)	ON DELETE CASCADE,
CONSTRAINT fk_correlationmatrix2 FOREIGN KEY (tag_id_to)
REFERENCES	TAG(tag_id)	ON DELETE CASCADE
);

CREATE TABLE USER_INTEREST(
user_id NUMBER NOT NULL,
tag_id NUMBER NOT NULL,
topic VARCHAR(200) ,
timestamp VARCHAR(200) ,
CONSTRAINT pk_userinterest1 PRIMARY KEY(user_id ,tag_id),
CONSTRAINT fk_userinterest1 FOREIGN KEY (tag_id)
REFERENCES	TAG(tag_id)	ON DELETE CASCADE,
CONSTRAINT fk_userinterest2 FOREIGN KEY (user_id)
REFERENCES	USER_INFO(user_id)	ON DELETE CASCADE
);


-- pl/sql for inserting files
declare
  2    l_dir    varchar2(10) := 'EXT_DIR';
  3    l_file   varchar2(20) := 'movie.mp4';
  4    l_bfile  bfile;
  5    l_blob   blob;
  6  begin
  7    insert into test (id, movie)
  8      values (1, empty_blob())
  9      return movie into l_blob;
 10
 11    l_bfile := bfilename(l_dir, l_file);
 12    dbms_lob.fileopen(l_bfile, dbms_lob.file_readonly);
 13    dbms_lob.loadfromfile(l_blob, l_bfile, dbms_lob.getlength(l_bfile));
 14    dbms_lob.fileclose(l_bfile);
 15
 16  end;
 17  /

drop table PDF;
drop table VIDEO;
drop table COURSE_TAKEN;
drop table TAG_LECTURE;



 drop table USER_INFO CASCADE CONSTRAINTS;
 drop table AUTHENTICATION CASCADE CONSTRAINTS;
 drop table COURSE CASCADE CONSTRAINTS;
 drop table BLOCK CASCADE CONSTRAINTS;
 drop table CORRELATION_MATRIX CASCADE CONSTRAINTS;
 drop table COURSE_TAKEN CASCADE CONSTRAINTS;
 drop table PDF CASCADE CONSTRAINTS;
 drop table REQUESTED_COURSE CASCADE CONSTRAINTS;
 drop table TAG CASCADE CONSTRAINTS;
 drop table TAG_COURSE CASCADE CONSTRAINTS;
 drop table TAG_LECTURE CASCADE CONSTRAINTS;
 drop table USER_EXPERTISE CASCADE CONSTRAINTS;
 drop table USER_INTEREST CASCADE CONSTRAINTS;
 drop table VIDEO CASCADE CONSTRAINTS;
 drop table LECTURE CASCADE CONSTRAINTS;
 drop table LESSON CASCADE CONSTRAINTS;
 drop table TAG CASCADE CONSTRAINTS;

