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