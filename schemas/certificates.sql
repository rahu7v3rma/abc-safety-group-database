CREATE TABLE certificate (
    certificate_name TEXT NOT NULL,
    certificate_id VARCHAR(255) UNIQUE PRIMARY KEY NOT NULL,
    certificate_length TEXT,
    certificate_template TEXT
);

CREATE TABLE user_certificates (
    user_id VARCHAR(255) NOT NULL,
    certificate_id VARCHAR(255),
    course_id VARCHAR(255),
    completion_date TIMESTAMP NOT NULL,
    expiration_date TIMESTAMP,
    instructor_id VARCHAR(255),
    certificate_name VARCHAR(255),
    certificate_number VARCHAR(255) NOT NULL PRIMARY KEY,
    instructor_name VARCHAR(255),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE course_certificates (
    certificate_id VARCHAR(255) NOT NULL,
    course_id VARCHAR(255) NOT NULL
);