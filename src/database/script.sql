-- Database: social_network_db
-- PostgreSQL

-- DROP DATABASE social_network_db;

CREATE DATABASE social_network_db
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'pt_BR.UTF-8'
    LC_CTYPE = 'pt_BR.UTF-8'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;

GRANT ALL ON DATABASE social_network_db TO social_network_user;

GRANT ALL ON DATABASE social_network_db TO postgres;

--GRANT TEMPORARY, CONNECT ON DATABASE social_network_db TO PUBLIC;

-- tables:
CREATE TABLE customer (
  id SERIAL PRIMARY KEY NOT NULL,
  email varchar(64) NOT NULL,
  username varchar(32) NOT NULL,
  first_name varchar(32) NOT NULL,
  last_name varchar(128) NOT NULL,
  password varchar(256) NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL
);

CREATE TABLE follow (
  id SERIAL PRIMARY KEY NOT NULL,
  follower_customer_id SERIAL REFERENCES customer (id),
  followed_customer_id SERIAL REFERENCES customer (id),
  status SMALLINT DEFAULT 1 NOT NULL, -- 0: inativo | 1: ativo
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL
);

CREATE TABLE post (
  id SERIAL PRIMARY KEY NOT NULL,
  image varchar(512), -- temporariamente guarda apenas links
  text TEXT,
  customer_id SERIAL REFERENCES customer(id) NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL
);

CREATE TABLE comment (
  id SERIAL PRIMARY KEY NOT NULL,
  text TEXT NOT NULL,
  author_customer_id SERIAL REFERENCES customer(id) NOT NULL,
  post_id SERIAL REFERENCES post(id),
  comment_id SERIAL REFERENCES comment(id),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL
);

CREATE TABLE likes (
  id SERIAL PRIMARY KEY NOT NULL,
  author_customer_id SERIAL REFERENCES customer(id) NOT NULL,
  post_id SERIAL REFERENCES post(id),
  comment_id SERIAL REFERENCES comment(id),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL
);

-- ::Create functions and triggers::

--update updated_at timestamp func:
CREATE OR REPLACE FUNCTION set_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURNS NEW;
END;
$$ LANGUAGE plpgsql;

--update timestamp trigger: customer
CREATE TRIGGER set_timestamp_trigger
  BEFORE UPDATE ON customer
  FOR EACH ROW
  EXECUTE PROCEDURE set_timestamp();

--update timestamp trigger: follow
CREATE TRIGGER set_timestamp_trigger
  BEFORE UPDATE ON follow
  FOR EACH ROW
  EXECUTE PROCEDURE set_timestamp();

--update timestamp trigger: post
CREATE TRIGGER set_timestamp_trigger
  BEFORE UPDATE ON post
  FOR EACH ROW
  EXECUTE PROCEDURE set_timestamp();

--update timestamp trigger: comment
CREATE TRIGGER set_timestamp_trigger
  BEFORE UPDATE ON comment
  FOR EACH ROW
  EXECUTE PROCEDURE set_timestamp();

--update timestamp trigger: likes
CREATE TRIGGER set_timestamp_trigger
  BEFORE UPDATE ON likes
  FOR EACH ROW
  EXECUTE PROCEDURE set_timestamp();
