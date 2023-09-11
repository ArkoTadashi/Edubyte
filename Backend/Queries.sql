

-- 

-- Popular Courses
SELECT title
FROM COURSE
ORDER BY popularity DESC
LIMIT 5;

-- Get Courses by Category
SELECT title
FROM COURSE
WHERE category={input};

SELECT title
FROM COURSE
WHERE course_id=(SELECT course_id
    FROM COURSE_TAKEN
    WHERE user_id={input});




-- Course Page
SELECT COUNT(*)
FROM COURSE_TAKEN
WHERE course_id={input};

SELECT COUNT(*)
FROM COURSE_TAKEN
WHERE course_id={input} AND user_id={input};

SELECT title, description, total_contents, avg_duration, intro, block_count
FROM COURSE
WHERE course_id={input};

INSERT INTO COURSE_TAKEN VALUES ({course_id, user_id, current_date, current_date, 0, NULL, NULL, NULL})

UPDATE COURSE_TAKEN
SET lastviewed_block={block_id}
WHERE course_id={} AND user_id={}

UPDATE COURSE_TAKEN
SET lastviewed_block={lecture_id}
WHERE course_id={} AND user_id={}

UPDATE COURSE_TAKEN
SET lastviewed_block={lession_id}
WHERE course_id={} AND user_id={}



-- Block Page
SELECT title, serial
FROM BLOCK
WHERE course_id={input};

SELECT title
FROM LECTURE
WHERE block_id={input};


-- Lesson/Lecture Page
SELECT lesson_id, title, serial
FROM LESSON 
WHERE lecture_id={input};

SELECT lesson_id, title, serial, body
FROM LESSON
WHERE lesson_id={input};

SELECT video_id, serial, title, content, n_views
FROM VIDEO
WHERE lesson_id={input};

SELECT pdf_id, serial, title, content, n_views
FROM PDF
WHERE lesson_id={input};

UPDATE COURSE_TAKEN
SET completed_contents=completed_contents+1
WHERE course_id={} AND user_id={}

UPDATE VIDEO
SET n_views=n_views+1
WHERE video_id={}

UPDATE PDF
SET n_views=n_views+1
WHERE pdf_id={}





--


INSERT INTO COURSE VALUES({author_id, title, description, 0, 0, 0, 0, intro_vid, category, 0})

INSERT INTO BLOCK VALUES({course_id, title, body, (SELECT block_count+1 FROM COURSE WHERE course_id={}), 0})

UPDATE COURSE
SET block_count=block_count+1
WHERE course_id={}


INSERT INTO LECTURE VALUES({block_id, title, body, 0, (SELECT lec_count+1 FROM BLOCK WHERE block_id={}), -0-, 0})

UPDATE BLOCK
SET lec_count=lec_count+1
WHERE block_id={}


INSERT INTO LESSON VALUES({lecture_id, title, body, 0, (SELECT lesson_count+1 FROM LECTURE WHERE lecture_id={}), -0-, 0})

UPDATE LECTURE
SET lesson_count=lesson_count+1
WHERE lecture_id={}



INSERT INTO VIDEO VALUES({lesson_id, title, blobcontent, 0, 0})

INSERT INTO PDF VALUES({lesson_id, title, blobcontent, 0, 0})

UPDATE COURSE
SET total_contents=total_contents+1
WHERE course_id={}

UPDATE LESSON
SET contents=contents+1
WHERE lession_id={}


