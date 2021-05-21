const mysql = require('mysql')

const connection = mysql.createConnection({
    connectionimit: 100,
    host: 'localhost',
    user: 'root',
    port: 3306,
    password: 'root123456',
    database: 'react_demo',
    multipleStatements: true,
})

connection.connect()

module.exports = connection