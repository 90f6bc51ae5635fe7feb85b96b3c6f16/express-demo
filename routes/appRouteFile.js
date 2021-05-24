const file_controller = require('../controllers/FileController')

module.exports = function (app) {
    app.post('/upload-file', file_controller.uploadFile)

    app.post('/delete-file', async function (req, res) {
        const result = await file_controller.deleteFile(req.body)
        res.send(result)
    })
}