const farm_model = require('../models/FarmModel');
const Task = function (task) {
    this.task = task.task;
};
Task.getFarmBy = async function getFarmBy(data) {
    const result = await farm_model.getFarmBy(data);
    return result
}
module.exports = Task;