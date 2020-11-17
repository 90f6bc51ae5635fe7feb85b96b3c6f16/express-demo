const user_controller = require('../controllers/UserController')

module.exports = function (app) {

    app.post('/user/checkLogin', async function (req, res) {
        const result = await user_controller.checkLogin(req.body)
        res.send(result)
    })
    app.post('/user/getUserBy', async function (req, res) {
        const result = await user_controller.getUserBy(req.body)
        res.send(result)
    })
    app.post('/user/getUserByID', async function (req, res) {
        const result = await user_controller.getUserByID(req.body)
        res.send(result)
    })
    app.post('/user/checkUsernameBy', async function (req, res) {
        const result = await user_controller.checkUsernameBy(req.body)
        res.send(result)
    })
    app.post('/user/insertUser', async function (req, res) {
        const result = await user_controller.insertUser(req.body)
        res.send(result)
    })
    app.post('/user/updateUser', async function (req, res) {
        const result = await user_controller.updateUser(req.body)
        res.send(result)
    })
    app.post('/user/deleteUserByID', async function (req, res) {
        const result = await user_controller.deleteUserByID(req.body)
        res.send(result)
    })

}