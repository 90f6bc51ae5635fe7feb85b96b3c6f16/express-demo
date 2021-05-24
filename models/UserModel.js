const connection = require('./BaseModel');
const Task = function (task) {
    this.task = task.task;
};

Task.checkLogin = function checkLogin(data) {
    return new Promise(function (resolve) {
        const sql = `SELECT *
            FROM tb_user
            WHERE user_username = ${connection.escape(data.user_username)}
            AND user_password = ${connection.escape(data.user_password)}
            `
        connection.query(sql, function (err, res) {
            if (err) {
                const require = { data: [], error: err, query_result: false, server_result: true, };
                resolve(require);
            } else {
                const require = { data: res, error: [], query_result: true, server_result: true, };
                resolve(require);
            }
        })
    })
}

Task.getUserLastCode = function getUserLastCode(data) {
    return new Promise(function (resolve) {
        var sql = `SELECT CONCAT(${connection.escape(data.code)}, LPAD(IFNULL(MAX(CAST(SUBSTRING(user_code,${data.code.length + 1},${data.digit}) AS SIGNED)),0) + 1,${data.digit},0)) AS last_code 
                FROM tb_user 
                WHERE user_code LIKE (${connection.escape(`${data.code}%`)}) 
                `;
        connection.query(sql, function (err, res) {
            if (err) {
                const require = { data: [], error: err, query_result: false, server_result: true, };
                resolve(require);
            } else {
                const require = { data: res[0].last_code, error: [], query_result: true, server_result: true, };
                resolve(require);
            }
        });
    });
}

Task.getUserBy = function getUserBy(data) {
    return new Promise(function (resolve) {
        let condition = ''
        if (data.keyword === undefined) data.keyword = ''
        if (data.user_code !== '' && data.user_code !== undefined) condition += `AND user_code = '${data.user_code}' `
        if (data.user_type_id !== '' && data.user_type_id !== undefined) condition += `AND user_type_id = '${data.user_type_id}' `
        if (data.user_active !== '' && data.user_active !== undefined) condition += `AND user_active = '${data.user_active}' `
        if (data.farm_id !== '' && data.farm_id !== undefined) condition += `AND farm_id = '${data.farm_id}' `

        const sql = `SELECT * 
            FROM tb_user
            WHERE (user_name  LIKE ('%${data.keyword}%'))
            ${condition}; 
                    `
        connection.query(sql, function (err, res) {
            if (err) {
                const require = { data: [], error: err, query_result: false, server_result: true, };
                resolve(require);
            } else {
                const require = { data: res, error: [], query_result: true, server_result: true, };
                resolve(require);
            }
        });
    });
}
Task.getUserByCode = function getUserByCode(data) {
    return new Promise(function (resolve) {
        const sql = `SELECT * 
            FROM tb_user
            WHERE user_code  = ${connection.escape(data.user_code)}
                    `
        connection.query(sql, function (err, res) {
            if (err) {
                const require = { data: [], error: err, query_result: false, server_result: true, };
                resolve(require);
            } else {
                const require = { data: res, error: [], query_result: true, server_result: true, };
                resolve(require);
            }
        });
    });
}
Task.checkUsernameBy = function acheckUsernameBy(data) {
    let condition = ''
    if (data.user_code !== '' && data.user_code !== undefined) condition += `AND user_code = '${data.user_code}' `
    return new Promise(function (resolve) {
        const sql = `SELECT * 
            FROM tb_user
            WHERE user_username  = ${connection.escape(data.user_username)}
            ${condition}
                 `
        connection.query(sql, function (err, res) {
            if (err) {
                const require = { data: [], error: err, query_result: false, server_result: true, };
                resolve(require);
            } else {
                const require = { data: res, error: [], query_result: true, server_result: true, };
                resolve(require);
            }
        });
    });
}


Task.insertUser = function insertUser(data) {
    return new Promise(function (resolve) {
        const sql = `INSERT INTO tb_user (
            user_code,
            user_prename,
            user_name,
            user_lastname,
            user_username,
            user_password,
            user_type_id,
            user_active,
            user_image
            ) VALUES (
            ${connection.escape(data.user_code)},
            ${connection.escape(data.user_prename)},
            ${connection.escape(data.user_name)},
            ${connection.escape(data.user_lastname)},
            ${connection.escape(data.user_username)},
            ${connection.escape(data.user_password)},
            ${connection.escape(data.user_type_id)},
            ${connection.escape(data.user_active)},
            ${connection.escape(data.user_image)}
            );
            `
        connection.query(sql, function (err, res) {
            if (err) {
                const require = { data: [], error: err, query_result: false, server_result: true, };
                resolve(require);
            } else {
                const require = { data: res, error: [], query_result: true, server_result: true, };
                resolve(require);
            }
        })
    })
}
Task.updateUser = function updateUser(data) {
    return new Promise(function (resolve) {
        const sql = `UPDATE tb_user SET
            user_prename = ${connection.escape(data.user_prename)},
            user_name = ${connection.escape(data.user_name)},
            user_lastname = ${connection.escape(data.user_lastname)},
            user_username = ${connection.escape(data.user_username)},
            user_password = ${connection.escape(data.user_password)},
            user_type_id = ${connection.escape(data.user_type_id)},
            user_active = ${connection.escape(data.user_active)},
            user_image = ${connection.escape(data.user_image)}
            WHERE user_code = ${connection.escape(data.user_code)}
            ;`
        connection.query(sql, function (err, res) {
            if (err) {
                const require = { data: [], error: err, query_result: false, server_result: true, };
                resolve(require);
            } else {
                const require = { data: res, error: [], query_result: true, server_result: true, };
                resolve(require);
            }
        })
    })
}
Task.deleteUserByCode = function deleteUserByCode(data) {
    return new Promise(function (resolve) {
        const sql = `DELETE FROM tb_user WHERE user_code = ${connection.escape(data.user_code)} ;`
        connection.query(sql, function (err, res) {
            if (err) {
                const require = { data: [], error: err, query_result: false, server_result: true, };
                resolve(require);
            } else {
                const require = { data: res, error: [], query_result: true, server_result: true, };
                resolve(require);
            }
        })
    })
}
module.exports = Task;
