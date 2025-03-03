CREATE TABLE forms (
    form_id VARCHAR(255) PRIMARY KEY UNIQUE NOT NULL,
    form_name TEXT NOT NULL,
    form_type VARCHAR(25) NOT NULL, --registration form/quiz/survey
    create_dtm TIMESTAMP NOT NULL, 
    modify_dtm TIMESTAMP NOT NULL,
    created_by VARCHAR(255) NOT NULL,
    modified_by VARCHAR(255) NOT NULL,
    active BOOLEAN NOT NULL,
    expiration_date TIMESTAMP,
    attempts INT NOT NULL,
    duration INT
);

CREATE TABLE form_submissions (
    form_id VARCHAR(255) NOT NULL,
    user_id VARCHAR(255) NOT NULL,
    response_id TEXT UNIQUE NOT NULL,
    create_dtm TIMESTAMP NOT NULL,
    modify_dtm TIMESTAMP NOT NULL,
    passing BOOLEAN,
    score FLOAT,
    possible_score FLOAT,
    is_complete BOOLEAN NOT NULL,
    course_id VARCHAR(255) NOT NULL,
    series_number VARCHAR(255) NOT NULL,
    FOREIGN KEY (form_id) REFERENCES forms(form_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE course_forms (
    course_id VARCHAR(255) NOT NULL,
    form_id VARCHAR(255) NOT NULL,
    create_dtm TIMESTAMP NOT NULL,
    modify_dtm TIMESTAMP NOT NULL,
    created_by VARCHAR(255) NOT NULL,
    modified_by VARCHAR(255) NOT NULL,
    available BOOLEAN NOT NULL,
    is_complete BOOLEAN NOT NULL,
    series_number INT,
    FOREIGN KEY (course_id) REFERENCES courses(course_id),
    FOREIGN KEY (form_id) REFERENCES forms(form_id)
);