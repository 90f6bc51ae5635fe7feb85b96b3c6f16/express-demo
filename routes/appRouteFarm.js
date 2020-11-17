const farm_controller = require('../controllers/FarmController')
module.exports = function (app) {
    app.post('/fram/getFarmBy', async function (req, res) {
        const result = await farm_controller.getFarmBy(req.body)
        res.send(result)
    })
}