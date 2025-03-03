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