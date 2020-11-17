const mysql = require('mysql')

const connection = mysql.createConnection({
    connectionimit: 100,
    host: 'localhost',
    user: 'root',
    port: 3306,
    password: 'root123456',
    database: 'db_swine',
    multipleStatements: true,
})

connection.connect()

module.exports = connection