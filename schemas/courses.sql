CREATE TABLE courses (
    course_id VARCHAR(255) UNIQUE NOT NULL PRIMARY KEY,
    course_name VARCHAR(255) NOT NULL,
    brief_description VARCHAR(255),
    "description" TEXT,
    instruction_types VARCHAR(25) ARRAY NOT NULL, --reffering to remote, inperson, both
    remote_link TEXT,
    "address" TEXT, -- physical "address"
    max_students INT NOT NULL, 
    classes_in_series INT NOT NULL, --claculated by number of classes between first and last class
    class_frequency VARCHAR(25) NOT NULL, -- weekly, monthly, yearly, bi-weekly
    active BOOLEAN NOT NULL,
    enrollment_start_date TIMESTAMP, --timestamp of when enrollment was opened
    registration_expiration_dtm TIMESTAMP NOT NULL, --default to end of day prior to course start
    create_dtm TIMESTAMP NOT NULL, 
    modify_dtm TIMESTAMP NOT NULL,
    created_by VARCHAR(255) NOT NULL, -- user who created the course
    modified_by VARCHAR(255) NOT NULL, -- user who last motified the course
    auto_student_enrollment BOOLEAN NOT NULL, --default box is checked if no prerequisits. Toggles admin approval requirement default to true
    waitlist BOOLEAN NOT NULL, --toggles waiting list option
    waitlist_limit INT,
    price FLOAT NOT NULL,
    allow_cash BOOLEAN NOT NULL, -- if check off, automatically require admin approval for enrollment
    phone_number VARCHAR(25) NOT NULL,
    course_picture VARCHAR(255),
    is_complete BOOLEAN NOT NULL,
    requirements TEXT ARRAY,
    is_full BOOLEAN NOT NULL,
    languages TEXT ARRAY NOT NULL,
    first_class_dtm TIMESTAMP NOT NULL,
    email VARCHAR(255) NOT NULL,
    course_code VARCHAR(255),
    "certificate" BOOLEAN,
    live_classroom BOOLEAN
);

CREATE TABLE course_bundles (
    bundle_id VARCHAR(255) PRIMARY KEY UNIQUE NOT NULL,
    bundle_name VARCHAR(255) NOT NULL,
    active BOOLEAN,
    enrollment_start_date TIMESTAMP, --timestamp of when enrollment was opened
    registration_expiration_dtm TIMESTAMP, --default to end of day prior to first course start
    max_students INT NOT NULL,
    create_dtm TIMESTAMP NOT NULL, 
    modify_dtm TIMESTAMP NOT NULL,
    created_by VARCHAR(255) NOT NULL, -- user who created the course
    modified_by VARCHAR(255) NOT NULL, -- user who last motified the course
    auto_student_enrollment BOOLEAN NOT NULL, --default box is checked if no prerequisits. Toggles admin approval requirement default to true
    waitlist BOOLEAN NOT NULL, --toggles waiting list option
    waitlist_limit INT,
    price FLOAT NOT NULL,
    allow_cash BOOLEAN NOT NULL, -- if check off, automatically require admin approval for enrollment
    "description" TEXT,
    brief_description VARCHAR(255),
    bundle_photo TEXT,
    is_full BOOLEAN NOT NULL,
    is_complete BOOLEAN NOT NULL
);

CREATE TABLE prerequisites (
    course_id VARCHAR(255),
    bundle_id VARCHAR(255),
    prerequisite TEXT NOT NULL,
    FOREIGN KEY (bundle_id) REFERENCES course_bundles(bundle_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id),
    FOREIGN KEY (prerequisite) REFERENCES courses(course_id)
);

CREATE TABLE bundled_courses (
    bundle_id VARCHAR(255) NOT NULL,
    course_id VARCHAR(255) NOT NULL,
    FOREIGN KEY (bundle_id) REFERENCES course_bundles(bundle_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

CREATE TABLE course_dates (
    is_complete BOOLEAN NOT NULL,
    course_id VARCHAR(255) NOT NULL,
    series_number INT NOT NULL,
    start_dtm TIMESTAMP NOT NULL,
    end_dtm TIMESTAMP NOT NULL,
    in_progress BOOLEAN NOT NULL,
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

CREATE TABLE course_instructor (
    course_id VARCHAR(255) NOT NULL,
    user_id VARCHAR(255) NOT NULL,
    FOREIGN KEY (course_id) REFERENCES courses(course_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE course_registration (
    course_id VARCHAR(255) NOT NULL,
    user_id VARCHAR(255) NOT NULL,
    registration_status VARCHAR(25) NOT NULL, --can be waitlist,pending,denied,enrolled. Wait list only option if wait.ist enbaled on course
    student_registration_date TIMESTAMP NOT NULL, --meaning date student fills out the class registration form
    enroll_date TIMESTAMP, --same as student_registration_date except for when admin approval required for student enrollment
    denial_reason TEXT,
    user_paid BOOLEAN NOT NULL,
    using_cash BOOLEAN NOT NULL,
    notes TEXT,
    modify_dtm TIMESTAMP,
    FOREIGN KEY (course_id) REFERENCES courses(course_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE course_content (
    course_id VARCHAR(255) NOT NULL,
    content_id VARCHAR(255) NOT NULL UNIQUE,
    content_name TEXT NOT NULL,
    create_dtm TIMESTAMP NOT NULL, 
    modify_dtm TIMESTAMP NOT NULL,
    created_by VARCHAR(255) NOT NULL, -- user who created the course
    modified_by VARCHAR(255) NOT NULL, -- user who last motified the course
    published BOOLEAN NOT NULL,
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

CREATE TABLE class_details (
    course_id VARCHAR(255) NOT NULL,
    series_number INT NOT NULL,
    user_id VARCHAR(255) NOT NULL,
    sign_in BOOLEAN NOT NULL,
    sign_out BOOLEAN NOT NULL,
    "absent" BOOLEAN NOT NULL,
    notes TEXT,
    create_dtm TIMESTAMP NOT NULL, 
    modify_dtm TIMESTAMP NOT NULL,
    created_by VARCHAR(255) NOT NULL, -- user who created the course
    modified_by VARCHAR(255) NOT NULL,
    FOREIGN KEY (course_id) REFERENCES courses(course_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);