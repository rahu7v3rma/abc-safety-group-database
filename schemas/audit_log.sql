CREATE TABLE audit_log (
    audit_id VARCHAR(255) PRIMARY KEY UNIQUE NOT NULL,
    "route" VARCHAR(255) NOT NULL,
    "details" TEXT NOT NULL,
    create_dtm TIMESTAMP NOT NULL,
    user_id VARCHAR(255) NOT NULL
);