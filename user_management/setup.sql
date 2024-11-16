CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(50) NOT NULL
);

CREATE TABLE software (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT
);

CREATE TABLE requests (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id),
    software_id INT REFERENCES software(id),
    access_type VARCHAR(50),
    reason TEXT,
    status VARCHAR(50)
);
CREATE TABLE requests (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id),
    software_id INT NOT NULL,
    access_type VARCHAR(255) NOT NULL,
    reason VARCHAR(255),
    status VARCHAR(50) NOT NULL
);
