CREATE TABLE USER_INFO(
user_id NUMBER NOT NULL,
name VARCHAR2(50) ,
email VARCHAR2(50),
birth_date VARCHAR2(50),
location VARCHAR2(250),
institution VARCHAR2(250),
lvl NUMBER,
term NUMBER,
CONSTRAINT pk_user1 PRIMARY KEY(user_id)
);



CREATE TABLE AUTHENTICATION(
user_id NUMBER NOT NULL,
auth_type VARCHAR2(50) ,
username VARCHAR2(50),
hassed_password VARCHAR2(250),

CONSTRAINT pk_authentication1 PRIMARY KEY(user_id)
);



CREATE TABLE REQUESTED_COURSE(
request_id NUMBER NOT NULL,
user_id NUMBER,
request_type VARCHAR2(50) ,
title VARCHAR2(50),
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
title VARCHAR2(50) ,
description VARCHAR2(50),
is_live NUMBER,
total_contents NUMBER,
block_count NUMBER,
total_duration NUMBER,
intro BLOB,
CONSTRAINT pk_course1 PRIMARY KEY(courseid),
CONSTRAINT fk_course1 FOREIGN KEY (author_id)
REFERENCES	USER_INFO(user_id)	ON DELETE CASCADE
);




CREATE TABLE LECTURE(
lecture_id NUMBER NOT NULL,
course_id NUMBER ,
author_id NUMBER ,
title VARCHAR2(50) ,
body VARCHAR2(50),
is_live NUMBER,
serial NUMBER,
n_views NUMBER,
CONSTRAINT pk_lecture1 PRIMARY KEY(lecture_id),
CONSTRAINT fk_lecture1 FOREIGN KEY (author_id)
REFERENCES	USER_INFO(user_id)	ON DELETE CASCADE,
CONSTRAINT fk_lecture2 FOREIGN KEY (course_id)
REFERENCES	COURSE(courseid)	ON DELETE CASCADE
);



CREATE TABLE PDF(
pdf_id NUMBER NOT NULL,
lecture_id NUMBER ,
author_id NUMBER ,
title VARCHAR2(50) ,
body VARCHAR2(1000),
content BLOB,
is_live NUMBER,
serial NUMBER,
n_views NUMBER,
CONSTRAINT pk_pdf1 PRIMARY KEY(pdf_id),
CONSTRAINT fk_pdf1 FOREIGN KEY (author_id)
REFERENCES	USER_INFO(user_id)	ON DELETE CASCADE,
CONSTRAINT fk_pdf2 FOREIGN KEY (lecture_id)
REFERENCES	LECTURE(lecture_id)	ON DELETE CASCADE
);




CREATE TABLE VIDEO(
video_id NUMBER NOT NULL,
lecture_id NUMBER ,
author_id NUMBER ,
title VARCHAR2(50) ,
body VARCHAR2(1000),
content BLOB,
is_live NUMBER,
serial NUMBER,
n_views NUMBER,
CONSTRAINT pk_video1 PRIMARY KEY(video_id),
CONSTRAINT fk_video1 FOREIGN KEY (author_id)
REFERENCES	USER_INFO(user_id)	ON DELETE CASCADE,
CONSTRAINT fk_video2 FOREIGN KEY (lecture_id)
REFERENCES	LECTURE(lecture_id)	ON DELETE CASCADE
);





CREATE TABLE COURSE_TAKEN(
courseid NUMBER NOT NULL,
userid NUMBER NOT NULL,
last_access_date VARCHAR2(50) ,
enrollment_date VARCHAR2(50),
completed_contents NUMBER,
lastviewed_lecture NUMBER,
lastviewed_pdf NUMBER,
lastviewed_video NUMBER,
CONSTRAINT pk_coursetaken1 PRIMARY KEY(userid,courseid),
CONSTRAINT fk_coursetaken1 FOREIGN KEY (userid)
REFERENCES	USER_INFO(user_id)	ON DELETE CASCADE,
CONSTRAINT fk_coursetaken2 FOREIGN KEY (courseid)
REFERENCES	COURSE(courseid)	ON DELETE CASCADE,

CONSTRAINT fk_coursetaken3 FOREIGN KEY (lastviewed_lecture)
REFERENCES	LECTURE(lecture_id)	ON DELETE CASCADE,
CONSTRAINT fk_coursetaken4 FOREIGN KEY (lastviewed_pdf)
REFERENCES	PDF(pdf_id)	ON DELETE CASCADE,
CONSTRAINT fk_coursetaken5 FOREIGN KEY (lastviewed_video)
REFERENCES	VIDEO(video_id)	ON DELETE CASCADE
);





CREATE TABLE TAG(
tag_id NUMBER NOT NULL,
tag_name VARCHAR2(50),
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
topic VARCHAR2(50) ,
timestamp VARCHAR2(50) ,
CONSTRAINT pk_userinterest1 PRIMARY KEY(user_id ,tag_id),
CONSTRAINT fk_userinterest1 FOREIGN KEY (tag_id)
REFERENCES	TAG(tag_id)	ON DELETE CASCADE,
CONSTRAINT fk_userinterest2 FOREIGN KEY (user_id)
REFERENCES	USER_INFO(user_id)	ON DELETE CASCADE
);


CREATE TABLE BLOCK(
block_id NUMBER NOT NULL,
course_id NUMBER ,
title VARCHAR2(50) ,
body VARCHAR2(50),
is_live NUMBER,
serial NUMBER,
n_views NUMBER,
contents NUMBER,
CONSTRAINT pk_block1 PRIMARY KEY(block_id),
CONSTRAINT fk_block2 FOREIGN KEY (course_id)
REFERENCES	COURSE(courseid)	ON DELETE CASCADE
);
