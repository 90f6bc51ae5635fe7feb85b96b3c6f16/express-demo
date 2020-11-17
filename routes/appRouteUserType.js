const user_type_controller = require('../controllers/UserTypeController')

module.exports = function (app) {
    app.post('/user-type/getUserTypeBy', async function (req, res) {
        const result = await user_type_controller.getUserTypeBy(req.body)
        res.send(result)
    })

}