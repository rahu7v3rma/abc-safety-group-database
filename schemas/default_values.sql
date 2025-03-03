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
    middle_name,
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
    '6e26fe26-da34-4726-bd60-872184c72914',
    'aldnadln',
    'adafbb',
    'askjbdak',
    '123@123.com',
    '123',
    '01/01/2000',
    '1234',
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
    '6e26fe26-da34-4726-bd60-872184c72914',
    '7a3d85a9-d057-46f7-af4f-802aaaaf7292'
);

INSERT INTO users (
    user_id,
    first_name,
    middle_name,
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
    '82911559-c0d2-40ee-b360-d45d549b227c',
    'admin',
    'adafbb',
    'admin',
    'admin@123.com',
    '1234',
    '01/01/2000',
    '12345',
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
    '82911559-c0d2-40ee-b360-d45d549b227c',
    '5078137a-52b7-47bb-811d-4801b7ecb1f9'
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

INSERT INTO courses (
    course_id,
    course_name,
    brief_description,
    description,
    instruction_types,
    remote_link,
    max_students,
    classes_in_series, --claculated by number of classes between first and last class
    class_frequency, -- weekly, monthly, yearly, bi-weekly
    active,
    enrollment_start_date, --timestamp of when enrollment was opened
    registration_expiration_dtm, --default to end of day prior to course start
    create_dtm, 
    modify_dtm,
    created_by, -- user who created the course
    modified_by, -- user who last motified the course
    auto_student_enrollment, --default box is checked if no prerequisits. Toggles admin approval requirement default to true
    waitlist, --toggles waiting list option
    waitlist_limit,
    price,
    allow_cash, -- if check off, automatically require admin approval for enrollment
    phone_number,
    course_picture,
    is_complete,
    requirements,
    is_full,
    languages,
    first_class_dtm,
    email
)
VALUES (
    '8b3b42b7-508f-44c1-9231-96cbca82bced',
    'Math',
    'This course teaches math',
    'askjdnaskjdbbaskjdbaksjdbaksbdkajsbdkajbsdkjabsdkjabsdkjbadkjbkjb',
    ARRAY['Remote'],
    'https://zoom.com',
    20,
    5,
    'weekly',
    true,
    '2023-07-28 23:39:21',
    '2023-07-30 23:39:21',
    '2023-07-28 23:39:21',
    '2023-07-28 23:39:21',
    '82911559-c0d2-40ee-b360-d45d549b227c',
    '82911559-c0d2-40ee-b360-d45d549b227c',
    true,
    true,
    20,
    100.00,
    true,
    '6789998212',
    'asjkhdakjhjkj',
    false,
    ARRAY['book', 'pencil', 'notebook'],
    false,
    ARRAY['English', 'Spanish'],
    '2023-07-28 23:39:21',
    'haha@haha.com'
);

INSERT INTO courses (
    course_id,
    course_name,
    brief_description,
    description,
    instruction_types,
    "address",
    max_students,
    classes_in_series, --claculated by number of classes between first and last class
    class_frequency, -- weekly, monthly, yearly, bi-weekly
    active,
    enrollment_start_date, --timestamp of when enrollment was opened
    registration_expiration_dtm, --default to end of day prior to course start
    create_dtm, 
    modify_dtm,
    created_by, -- user who created the course
    modified_by, -- user who last motified the course
    auto_student_enrollment, --default box is checked if no prerequisits. Toggles admin approval requirement default to true
    waitlist, --toggles waiting list option
    waitlist_limit,
    price,
    allow_cash, -- if check off, automatically require admin approval for enrollment
    phone_number,
    course_picture,
    is_complete,
    requirements,
    is_full,
    languages,
    first_class_dtm,
    email
)
VALUES (
    '8b3b42b7-508f-44c1-9231-96cbca822ced',
    'English',
    'This course teaches english',
    'askjdnaskjdbbaskjdbaksjdbaksbdkajsbdkajbsdkjabsdkjabsdkjbadkjbkjb',
    ARRAY['In-Person'],
    '1234 abc road',
    20,
    5,
    'weekly',
    true,
    '2023-07-28 23:39:21',
    '2023-07-30 23:39:21',
    '2023-07-28 23:39:21',
    '2023-07-28 23:39:21',
    '82911559-c0d2-40ee-b360-d45d549b227c',
    '82911559-c0d2-40ee-b360-d45d549b227c',
    true,
    true,
    20,
    100.00,
    true,
    '6789998212',
    'asjkhdakjhjkj',
    false,
    ARRAY['book', 'pencil', 'notebook'],
    false,
    ARRAY['English', 'Spanish'],
    '2023-07-28 23:39:21',
    'haha@haha.com'
);

INSERT INTO course_dates (
    is_complete,
    course_id,
    series_number,
    start_dtm,
    end_dtm
)
VALUES 
(false, '8b3b42b7-508f-44c1-9231-96cbca82bced', 1, '2023-10-19 22:00:00', '2023-10-19 23:00:00'),
(false, '8b3b42b7-508f-44c1-9231-96cbca82bced', 2, '2023-10-21 22:00:00', '2023-10-21 23:00:00'),
(false, '8b3b42b7-508f-44c1-9231-96cbca82bced', 3, '2023-10-23 22:00:00', '2023-10-23 23:00:00'),
(false, '8b3b42b7-508f-44c1-9231-96cbca822ced', 1, '2023-10-19 22:00:00', '2023-10-19 23:00:00'),
(false, '8b3b42b7-508f-44c1-9231-96cbca822ced', 2, '2023-10-21 22:00:00', '2023-10-21 23:00:00'),
(false, '8b3b42b7-508f-44c1-9231-96cbca822ced', 3, '2023-10-23 22:00:00', '2023-10-23 23:00:00')