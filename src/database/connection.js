const { Pool } = require('pg');
require('dotenv/config');

const pool = new Pool({
  user: process.env.DB_USER,
  host: process.env.HOST,
  database: process.env.DATABASE,
  password: process.env.PASSWORD,
  port: process.env.PORT
})
// const pool = new Pool({
//   user: 'social_network_user',
//   host: '127.0.0.1',
//   database: 'social_network_db',
//   password: 'social_network_user',
//   port: 5432
// })
module.exports = pool;