const Pool = require('pg').Pool
var pool = new Pool({
  user: 'postgres',
  host: 'localhost',
  database: 'DB_Keluarga_Berencana',
  password: '1q2w3e',
  port: 5432,
})

module.exports = pool;
