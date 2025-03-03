CREATE TABLE users (
    user_id VARCHAR(255) PRIMARY KEY UNIQUE NOT NULL,
    first_name VARCHAR(125) NOT NULL,
    middle_name VARCHAR(125),
    last_name VARCHAR(125) NOT NULL,
    suffix VARCHAR(25),
    email VARCHAR(125) UNIQUE,
    phone_number VARCHAR(25) UNIQUE,
    dob TIMESTAMP,
    eye_color VARCHAR(125),
    height INT,
    head_shot VARCHAR(255),
    photo_id VARCHAR(255),
    other_id VARCHAR(255),
    photo_id_photo VARCHAR(255),
    other_id_photo VARCHAR(255),
    "password" VARCHAR(255),
    time_zone VARCHAR(50),
    create_dtm TIMESTAMP NOT NULL,
    modify_dtm TIMESTAMP NOT NULL,
    active BOOLEAN NOT NULL,
    expiration_date TIMESTAMP,
    text_notif BOOLEAN NOT NULL,
    email_notif BOOLEAN NOT NULL,
    "address" TEXT,
    city VARCHAR(255),
    "state" VARCHAR(255),
    zipcode INT,
    gender VARCHAR(255)
);

CREATE TABLE permissions (
    permission_id VARCHAR(255) PRIMARY KEY UNIQUE NOT NULL,
    permission_desc VARCHAR(255) NOT NULL,
    permission_node VARCHAR(255) NOT NULL,
    active BOOLEAN NOT NULL,
    create_dtm TIMESTAMP NOT NULL,
    modify_dtm TIMESTAMP NOT NULL,
    expiration_date TIMESTAMP
);

CREATE TABLE roles (
    role_id VARCHAR(255) PRIMARY KEY NOT NULL UNIQUE,
    role_name VARCHAR(255) NOT NULL UNIQUE,
    role_desc VARCHAR(255),
    active BOOLEAN NOT NULL,
    create_dtm TIMESTAMP NOT NULL,
    modify_dtm TIMESTAMP NOT NULL,
    expiration_date TIMESTAMP
);

CREATE TABLE role_permissions (
    role_id VARCHAR(255) NOT NULL,
    permission_id VARCHAR(255) NOT NULL,
    active BOOLEAN NOT NULL,
    modify_dtm TIMESTAMP NOT NULL,
    create_dtm TIMESTAMP NOT NULL,
    FOREIGN KEY (role_id) REFERENCES roles(role_id),
    FOREIGN KEY (permission_id) REFERENCES permissions(permission_id)
);

CREATE TABLE user_role (
    user_id VARCHAR(255) NOT NULL,
    role_id VARCHAR(255) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (role_id) REFERENCES roles(role_id)
);

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
    series_number INT NOT NULL,
    FOREIGN KEY (form_id) REFERENCES forms(form_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
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

CREATE TABLE audit_log (
    audit_id VARCHAR(255) PRIMARY KEY UNIQUE NOT NULL,
    "route" VARCHAR(255) NOT NULL,
    "details" TEXT NOT NULL,
    create_dtm TIMESTAMP NOT NULL,
    user_id VARCHAR(255) NOT NULL
);

CREATE TABLE transactions (
    transaction_id VARCHAR(255) PRIMARY KEY UNIQUE NOT NULL,
    user_id VARCHAR(255) NOT NULL,
    "description" TEXT,
    create_dtm TIMESTAMP NOT NULL,
    modify_dtm TIMESTAMP NOT NULL,
    created_by VARCHAR(255) NOT NULL,
    modified_by VARCHAR(255) NOT NULL,
    course_id VARCHAR(255),
    bundle_id VARCHAR(255),
    amount FLOAT NOT NULL,
    price FLOAT NOT NULL,
    void BOOLEAN NOT NULL,
    notes TEXT
);

INSERT INTO roles (
    role_id,
    role_name,
    role_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    '7a3d85a9-d057-46f7-af4f-802aaaaf7292',
    'student',
    'A role to specify a user with student permissions',
    true,
    '2023-07-09 23:39:21',
    '2023-07-09 23:39:21'
);

INSERT INTO roles (
    role_id,
    role_name,
    role_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    '2606eb1c-e7e9-4079-ad43-e305746e52d2',
    'instructor',
    'A role to specify a user with instructor permissions',
    true,
    '2023-07-09 23:39:21',
    '2023-07-09 23:39:21'
);

INSERT INTO roles (
    role_id,
    role_name,
    role_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    '5078137a-52b7-47bb-811d-4801b7ecb1f9',
    'admin',
    'A role to specify a user with admin permissions',
    true,
    '2023-07-09 23:39:21',
    '2023-07-09 23:39:21'
);

INSERT INTO roles (
    role_id,
    role_name,
    role_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    'b5343752-a988-42e6-9e01-3e2fa533fa30',
    'superuser',
    'A role to specify a user with super user permissions',
    true,
    '2023-07-09 23:39:21',
    '2023-07-09 23:39:21'
);

INSERT INTO users (
    user_id,
    first_name,
    last_name,
    email,
    phone_number,
    dob,
    password,
    time_zone,
    create_dtm,
    modify_dtm,
    active,
    text_notif,
    email_notif
)
VALUES (
    'd8adb06f-1db0-43be-8823-bd26460408fb',
    'instructor',
    'instructor',
    'instructor@123.com',
    '12345',
    '01/01/2000',
    '123456',
    'EST',
    '2023-07-09 23:39:21',
    '2023-07-09 23:39:21',
    true,
    true,
    true
);

INSERT INTO user_role (
    user_id,
    role_id
)
VALUES (
    'd8adb06f-1db0-43be-8823-bd26460408fb',
    '2606eb1c-e7e9-4079-ad43-e305746e52d2'
);

INSERT INTO users (
    user_id,
    first_name,
    last_name,
    email,
    phone_number,
    dob,
    password,
    time_zone,
    create_dtm,
    modify_dtm,
    active,
    text_notif,
    email_notif
)
VALUES (
    'd84gsd6f-1db0-43be-8823-bd26460408fb',
    'admin',
    'admin',
    'admin@admin.com',
    '123456',
    '01/01/2000',
    '$pbkdf2-sha256$29000$DCEEAADgXMtZyxmD0JrT2g$mhkymq1kyE49KOPVUpVU6Z7wLxjH5jCiK5UdD6Iaj1g',
    'EST',
    '2023-07-09 23:39:21',
    '2023-07-09 23:39:21',
    true,
    true,
    true
);

INSERT INTO user_role (
    user_id,
    role_id
)
VALUES (
    'd84gsd6f-1db0-43be-8823-bd26460408fb',
    '5078137a-52b7-47bb-811d-4801b7ecb1f9'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    '0119141f-bc5c-4fb3-868e-9a259d0fe693',
    'admin.*',
    'permission node for base admin permissions',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    '48b28472-dca3-4481-9ff7-1c841588f492',
    'admin.list_roles',
    'permission node to list all roles',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    'b1800057-fecd-47ed-ad2a-d1b8975e63a0',
    'admin.manage_roles',
    'permission node to manage a users roles',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    '5540f372-ac75-42bf-be81-6df66e6d19a2',
    'admin.generate_certificates',
    'permission node to generate certificates',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    'd9ffd9e2-4e41-491c-ab83-167a20eccf24',
    'admin.delete_certificates',
    'permission node to delete certificates',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    'd2293379-66c3-4f33-872e-a1ce3df953ff',
    'admin.delete_users',
    'permission node to delete users',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    '780f559c-5a53-4932-8fc1-ab803c2feb4d',
    'admin.deactivate_users',
    'permission node to deactivate users',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    'b1610cf6-76ec-4299-9d51-385a94db2077',
    'admin.activate_users',
    'permission node to activate users',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    '2c1d8df1-8aa7-4d23-b10c-06f33e585d9b',
    'admin.update_users',
    'permission node to update users',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    '69208354-a1b6-4c24-b4b8-76edfe4fc89c',
    'admin.expedited_register',
    'permission node for expedited register routes',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    'afd46e5e-ef08-492c-93e8-d313ce1c755f',
    'admin.bug_report',
    'permission node to submit a bug report',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    '20f065f4-4033-4541-97f6-a48c2373792b',
    'courses.*',
    'permission node for base courses routes',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    '0a979630-63cf-4bc9-a464-383b0f8c3cfd',
    'courses.list',
    'permission node for listing courses and bundles',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    '8fcf80d5-5991-4864-aca2-019f33525122',
    'courses.course_search',
    'permission node for searching courses and bundles',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    '3de5dca9-31fb-4a91-8dbd-b87f5acef0ae',
    'courses.assign_instructor',
    'permission node for assigning instructors to courses',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    'a9ac697c-868f-498a-9634-30b2bc3331ff',
    'courses.enroll_student',
    'permission node for enroll students to courses and bundles',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    '877eb7af-b880-4b2e-93a8-dd2cd408884a',
    'courses.self_enroll',
    'permission node for self enrolling into bundles and courses',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    '0c084ecb-0cc8-4797-b979-ca4bbd72da1d',
    'courses.delete',
    'permission node deleting courses and bundles',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    '3a5dc983-ba24-488e-a41a-4bd25101a733',
    'courses.create',
    'permission node creating courses and bundles',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    'e59e02ec-16f4-4bae-89a0-9cdd5610e896',
    'courses.load',
    'permission node loading courses and bundles',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    '97baefd5-6595-4d82-aa74-9e550a2f6046',
    'courses.schedule',
    'permission node for schedule for courses and bundles',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    '59d99d53-de1b-4b73-9cd8-dbbb36d3398a',
    'courses.schedule_search',
    'permission node for schedule searching for courses and bundles',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    '95acf906-3483-4047-bc3c-6478292bfffe',
    'courses.schedule_delete',
    'permission node for schedule deleting for courses and bundles',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    'b8c20ad3-cd1d-4230-a48d-1e67688c3e23',
    'courses.update',
    'permission node for updating courses and bundles',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    '5e52b90f-f2ea-4e40-bd06-c5af3e52ebaf',
    'courses.list_content',
    'permission node for listing courses content',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    '521daea1-ea7a-454f-981a-a5d2a21e43b5',
    'courses.enroll_update',
    'permission node for updating course and bundle enrollments',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    'd9787d77-31af-479d-8b64-a8048005e603',
    'courses.schedule_update',
    'permission node for updating course and bundle schedules',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    '0de521c4-2fab-40d5-bb89-376ab412e5c2',
    'courses.upload_content',
    'permission node for uploading course content',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    '53a36348-15b3-4d93-a5d8-18f23dc57b38',
    'courses.update_content',
    'permission node for updating course content',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    'cfdf13d8-c542-4f6c-a659-ad5377caaea1',
    'courses.delete_content',
    'permission node for deleting course content',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    'b102d45a-7287-4c73-824a-724bd65cc632',
    'courses.complete',
    'permission node for completing courses and bundles',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    '3fb52bba-3b31-495f-8916-9cd2fef86c3f',
    'courses.schedule_complete',
    'permission node for completing courses and bundles classes',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    '2d3b11a0-d616-4197-a3ae-565bf132c126',
    'data.*',
    'permission node for base data routes',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    '00c0f466-a2a3-4e60-8196-4a89a515194c',
    'data.export_certificates',
    'permission node for exporting certificates',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    '3315950e-a521-4d07-9f2e-f598974a9daf',
    'data.export_students',
    'permission node for exporting students',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    '3315950e-a521-6gc2-9f2e-f598974a9daf',
    'data.export_instructors',
    'permission node for exporting instructors',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    '3315950e-6ufs-6gc2-9f2e-f598974a9daf',
    'data.export_admins',
    'permission node for exporting admins',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    '333g8l0e-6ufs-6gc2-9f2e-f598974a9daf',
    'data.export_all',
    'permission node for exporting all',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    '8e6f39b4-1cb3-4ec4-9ac7-95c2e5b6e0be',
    'data.import_certificates',
    'permission node for importing certificates',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    '7d2fbc92-8982-487f-82d9-2abcf0c94c64',
    'data.download_certificates',
    'permission node for downloading certificates',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    '1bb30927-ed66-4ab8-af8b-5707b80664f6',
    'data.import_courses',
    'permission node for importing courses',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    '2a4c0d71-e8d9-4648-be18-b8e4b09e2692',
    'data.import_students',
    'permission node for importing students',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    '8e6892be-9f3a-4b71-88a9-410ae7d53052',
    'forms.*',
    'permission node for forms routes base',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    'b3c74229-0a30-43a7-90cb-120513d6d484',
    'forms.create_survey',
    'permission node for creating surveys',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    'ec430396-f092-4afd-8550-814a7946b00f',
    'forms.update_survey',
    'permission node for updating surveys',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    '8d146ea5-0bdc-43fa-8317-ca99b10537b8',
    'forms.load_survey',
    'permission node for loading surveys',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    '9e1b48c0-976c-45b9-92e4-92a8976b074a',
    'forms.create_quiz',
    'permission node for creating quizzes',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    '16b3a5cd-9eca-4db9-80de-a597c967407e',
    'forms.update_quiz',
    'permission node for updating quizzes',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    '40d99947-1b24-4603-a369-38a2bf8a0283',
    'forms.load_quiz',
    'permission node for loading quizzes',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    'df0715cc-9202-459a-8ab1-560a11dd54b4',
    'forms.list',
    'permission node for listing quizzes and surveys',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    '997b919f-6596-42bb-9854-0f32774ecb2c',
    'forms.submit_quiz',
    'permission node for submitting quizzes and surveys',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    '2331bec1-6c90-4ec4-b43b-c9be59a81f05',
    'forms.search',
    'permission node for searching quizzes and surveys',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    '1af95e2d-c6bd-4be9-9a74-caf2678ef87e',
    'transactions.*',
    'permission node for transaction routes base',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    '184d9457-802e-4f19-b0fa-338271f4c4e1',
    'transactions.list',
    'permission node for listing transactions',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    '3a2b37ac-1ca8-4299-a797-4435d66df53f',
    'transactions.void',
    'permission node for voiding transactions',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    '900b4ae6-0497-4ecb-a3b2-14fef520e801',
    'transactions.search',
    'permission node for searching transactions',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    'ef02a109-8579-4c5a-be6a-4ee3a9986800',
    'transactions.load',
    'permission node for loading transactions',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    '6561b846-113e-4a24-bb11-6d31bdc08f17',
    'transactions.update',
    'permission node for updating transactions',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    'e9f33b1f-7c83-4bb4-83d8-98644a101137',
    'users.*',
    'permission node for base users router routes',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    'ed243ea7-5c6d-4dd6-96c9-bbe04579a6c5',
    'users.profile',
    'permission node for loading users profiles',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    '17a3499a-9304-4371-8df5-0ce9aada38bf',
    'users.search_students',
    'permission node for searching users',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    '17a3499a-9fzjs-4371-8df5-0ce9aada38bf',
    'users.search_instructors',
    'permission node for searching instructors',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    '17a3499a-9fzjs-4371-9ohs-0ce9aada38bf',
    'users.search_admins',
    'permission node for searching admins',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    '17a3499a-9fzjs-4371-9ohs-996faada38bf',
    'users.search_all',
    'permission node for searching all',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    'd6571b47-093a-4092-b830-5b59be9bd481',
    'users.my_certificates',
    'permission node for loading self-certificates',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    '8246457e-ae47-47e1-8b56-4b7af65b4db5',
    'users.list_certificates',
    'permission node for listing certificates',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    '0bdd23a8-caa7-4bd1-800c-7954a8300dd3',
    'users.search_certificates',
    'permission node for searching certificates',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    '0757e25a-06a5-4333-b014-6c5926bd6024',
    'users.load_certificates',
    'permission node for loading certificates',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    '71a4f8b8-a33f-445a-8577-f8f9efb45db7',
    'users.list_students',
    'permission node for listing students',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    '71a4f8b8-a33f-445a-9742-f8f9efb45db7',
    'users.list_instructors',
    'permission node for listing instructors',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    '71a9ks38-a33f-445a-9742-f8f9efb45db7',
    'users.list_admins',
    'permission node for listing admins',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    '71a9ks38-a33f-445a-9742-f8f9efb890s7',
    'users.list_all',
    'permission node for listing all users',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    '8c2af70b-893c-4730-ab1b-8bcb6ae067cc',
    'users.register_users',
    'permission node for registering users',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    'cae0bf86-9899-440d-b996-4f997adec12f',
    'users.my_courses',
    'permission node for listing self-courses',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    'b4c17124-bf8b-4ef5-bb6f-06ee1ffcbc47',
    'users.my_schedule',
    'permission node for listing self-schedule',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    'b4c17124-bf8b-4ef5-bb6f-06edet6cbc47',
    'superuser',
    'permission node for everything',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    'b4c17124-bf8b-4ef5-bb6f-06edet7hbbc47',
    'courses.load_students',
    'permission node loading students for courses and bundles',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    '153a3b92-7285-469b-bd33-69a7a2ba31a1',
    'instructor.load_students',
    'permission node loading students for live class management',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    '5791e594-196c-4f31-9584-6978708b02b0',
    'instructor.*',
    'permission node all instructor routes',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    '5791e594-196c-4f31-9584-6978708b345',
    'instructor.start_forms',
    'permission node for starting quizzes/surveys',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    '5791e594-196c-4f31-9584-6978708b0864',
    'instructor.send_forms',
    'permission node for sending forms to students',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    '5791e594-196c-4f31-9584-6946828b0864',
    'instructor.update_students',
    'permission node for updating students in live classroom management',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    '5791e594-196c-4f31-7953-6946828b0864',
    'forms.take_form',
    'permission node for taking quizzes',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    '5791e594-476c-4f31-7953-6946828b0864',
    'instructor.send_attendance',
    'permission node for sending attendance sign in-out sheet',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    '50uf3594-476c-4f31-7953-6946828b0864',
    'instructor.send_class_details',
    'permission node for sending class details to students',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    '50uf3594-476c-4f31-7953-69468272k864',
    'instructor.submit_attendance',
    'permission node for live classroom signin/out submission',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);


INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    '50uf3594-476c-4f31-9ix2-69468272k864',
    'courses.load_class',
    'permission node for loading class details',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO "permissions" (
    permission_id,
    permission_node,
    permission_desc,
    active,
    create_dtm,
    modify_dtm
)
VALUES (
    '17a3499a-9fzjs-4371-8df5-0ce9927a38bf',
    'instructor.list_submission',
    'permission node listing form submissions',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);


-- DEFAULT ADMIN/SUPERUSER PERMS FOR EVERYTHING

-- INSERT INTO role_permissions (
--     role_id,
--     permission_id,
--     active,
--     modify_dtm,
--     create_dtm
-- )
-- VALUES (
--     '5078137a-52b7-47bb-811d-4801b7ecb1f9',
--     '5791e594-196c-4f31-9584-6978708b02b0',
--     true,
--     '2024-01-01 00:00:00',
--     '2024-07-01 00:00:00'
-- );

INSERT INTO role_permissions (
    role_id,
    permission_id,
    active,
    modify_dtm,
    create_dtm
)
VALUES (
    '5078137a-52b7-47bb-811d-4801b7ecb1f9',
    '0119141f-bc5c-4fb3-868e-9a259d0fe693',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO role_permissions (
    role_id,
    permission_id,
    active,
    modify_dtm,
    create_dtm
)
VALUES (
    '5078137a-52b7-47bb-811d-4801b7ecb1f9',
    '20f065f4-4033-4541-97f6-a48c2373792b',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

INSERT INTO role_permissions (
    role_id,
    permission_id,
    active,
    modify_dtm,
    create_dtm
)
VALUES (
    '5078137a-52b7-47bb-811d-4801b7ecb1f9',
    '2d3b11a0-d616-4197-a3ae-565bf132c126',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

-- INSERT INTO role_permissions (
--     role_id,
--     permission_id,
--     active,
--     modify_dtm,
--     create_dtm
-- )
-- VALUES (
--     '5078137a-52b7-47bb-811d-4801b7ecb1f9',
--     '1af95e2d-c6bd-4be9-9a74-caf2678ef87e',
--     true,
--     '2024-01-01 00:00:00',
--     '2024-07-01 00:00:00'
-- );

INSERT INTO role_permissions (
    role_id,
    permission_id,
    active,
    modify_dtm,
    create_dtm
)
VALUES (
    '5078137a-52b7-47bb-811d-4801b7ecb1f9',
    'e9f33b1f-7c83-4bb4-83d8-98644a101137',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);

-- INSERT INTO role_permissions (
--     role_id,
--     permission_id,
--     active,
--     modify_dtm,
--     create_dtm
-- )
-- VALUES (
--     '5078137a-52b7-47bb-811d-4801b7ecb1f9',
--     '8e6892be-9f3a-4b71-88a9-410ae7d53052',
--     true,
--     '2024-01-01 00:00:00',
--     '2024-07-01 00:00:00'
-- );

INSERT INTO role_permissions (
    role_id,
    permission_id,
    active,
    modify_dtm,
    create_dtm
)
VALUES (
    'b5343752-a988-42e6-9e01-3e2fa533fa30',
    'b4c17124-bf8b-4ef5-bb6f-06edet6cbc47',
    true,
    '2024-01-01 00:00:00',
    '2024-07-01 00:00:00'
);