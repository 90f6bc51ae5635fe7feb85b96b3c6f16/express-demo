const user_type_model = require('../models/UserTypeModel');
const Task = function (task) {
    this.task = task.task;
};

Task.getUserTypeBy = async function getUserTypeBy(data) {
    const result = await user_type_model.getUserTypeBy(data);
    return result
}

module.exports = Task;