const connection = require('./BaseModel');
const Task = function (task) {
    this.task = task.task;
};

Task.checkLogin = function checkLogin(data) {
    return new Promise(function (resolve) {
        console.log("checkLogin :", data);
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
Task.getUserBy = function getUserBy(data) {
    return new Promise(function (resolve) {
        let condition = ''
        if (data.keyword === undefined) data.keyword = ''
        if (data.user_id !== '' && data.user_id !== undefined) condition += `AND user_id = '${data.user_id}' `
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
Task.getUserByID = function getUserByID(data) {
    return new Promise(function (resolve) {
        const sql = `SELECT * 
            FROM tb_user
            WHERE user_id  = ${connection.escape(data.user_id)}
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
    if (data.user_id !== '' && data.user_id !== undefined) condition += `AND user_id = '${data.user_id}' `
    return new Promise(function (resolve) {
        const sql = `SELECT * 
            FROM tb_user
            WHERE user_username  = ${connection.escape(data.user_username)}
            ${condition}
                 `
        console.log("");
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
            user_prename,
            user_name,
            user_lastname,
            user_username,
            user_password,
            user_type_id,
            user_active,
            farm_id
            ) VALUES (
            ${connection.escape(data.user_prename)},
            ${connection.escape(data.user_name)},
            ${connection.escape(data.user_lastname)},
            ${connection.escape(data.user_username)},
            ${connection.escape(data.user_password)},
            ${connection.escape(data.user_type_id)},
            ${connection.escape(data.user_active)},
            ${connection.escape(data.farm_id)}
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
            farm_id = ${connection.escape(data.farm_id)}
            WHERE user_id = ${connection.escape(data.user_id)}
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
Task.deleteUserByID = function deleteUserByID(data) {
    return new Promise(function (resolve) {
        const sql = `DELETE FROM tb_user WHERE user_id = ${connection.escape(data.user_id)} ;`
        console.log("deleteUserByID", sql);

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
