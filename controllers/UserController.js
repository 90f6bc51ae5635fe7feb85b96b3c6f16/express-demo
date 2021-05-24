const user_model = require('../models/UserModel');
const Task = function (task) {
    this.task = task.task;
};
Task.checkLogin = async function checkLogin(data) {
    const result = await user_model.checkLogin(data);
    return result
}
Task.getUserLastCode = async function getUserLastCode(data) {
    const result = await user_model.getUserLastCode(data);
    return result
}
Task.getUserBy = async function getUserBy(data) {
    const result = await user_model.getUserBy(data);
    return result
}
Task.getUserByCode = async function getUserByCode(data) {
    const result = await user_model.getUserByCode(data);
    return result
}
Task.checkUsernameBy = async function checkUsernameBy(data) {
    const result = await user_model.checkUsernameBy(data);
    return result
}
Task.insertUser = async function insertUser(data) {
    const result = await user_model.insertUser(data);
    return result
}
Task.updateUser = async function updateUser(data) {
    const result = await user_model.updateUser(data);
    return result
}
Task.deleteUserByCode = async function deleteUserByCode(data) {
    const result = await user_model.deleteUserByCode(data);
    return result
}

module.exports = Task;