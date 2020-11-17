const user_model = require('../models/UserModel');
const Task = function (task) {
    this.task = task.task;
};
Task.checkLogin = async function checkLogin(data) {
    const result = await user_model.checkLogin(data);
    return result
}
Task.getUserBy = async function getUserBy(data) {
    const result = await user_model.getUserBy(data);
    return result
}
Task.getUserByID = async function getUserByID(data) {
    const result = await user_model.getUserByID(data);
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
Task.deleteUserByID = async function deleteUserByID(data) {
    const result = await user_model.deleteUserByID(data);
    return result
}

module.exports = Task;