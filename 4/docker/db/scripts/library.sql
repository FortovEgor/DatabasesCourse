CREATE DATABASE fortov_214;

\c fortov_214;

CREATE TABLE readers (
    id INTEGER PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    address VARCHAR(200),
    birthday DATE
);

CREATE TABLE publishers (
    id INTEGER PRIMARY KEY,
    pub_name VARCHAR(100),
    pub_kind VARCHAR(100)
);

CREATE TABLE categories (
    cat_name VARCHAR(100) PRIMARY KEY,
    parent VARCHAR(100) REFERENCES categories(cat_name)
);

CREATE TABLE books (
    isbn VARCHAR(18) PRIMARY KEY,
    title VARCHAR(100),
    author VARCHAR(200),
    pages_num INTEGER,
    pub_year INTEGER,
    category VARCHAR(100) REFERENCES categories(cat_name),
    publisher_id INTEGER REFERENCES publishers(id)
);

CREATE TABLE book_copies (
    id INTEGER PRIMARY KEY,
    isbn VARCHAR(18) REFERENCES books(isbn),
    position VARCHAR(100)
);

CREATE TABLE reader_borrows (
    reader_id INTEGER REFERENCES readers(id),
    book_id INTEGER REFERENCES book_copies(id),
    expiration_date DATE,
    PRIMARY KEY (reader_id, book_id)
);