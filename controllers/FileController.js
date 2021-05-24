const Task = function (task) {
    this.task = task.task
    this.status = task.status
    this.created_at = new Date()
}
 
const path = require('path')
const mkdirp = require('mkdirp')
const fs = require('fs')
const uuidv4 = require('uuid/v4')
const multer = require('multer')

Task.uploadFile = function uploadFile(req, res) {
    const upload = multer({
        storage: multer.diskStorage({
            destination: function (req, file, callback) {
                const filePath = path.join(__dirname, `../public/${req.body.upload_path}`)

                mkdirp.sync(filePath)
                callback(null, filePath)
            },
            filename: function (req, file, callback) {
                let name = file.originalname.split(".")

                callback(null, `${uuidv4()}.${name[name.length - 1]}`)
            }
        })
    }).single("files")

    upload(req, res, function (err) {
        if (!req.file) {
            res.send({ data: '', require: false, err: err, })
        } else {
            res.send({ data: { file_name: (req.body.upload_path + req.file.filename) }, require: true, })
        }
    })
}
Task.deleteFile = function deleteFile(data) {
    return new Promise((resolve, reject) => {
        fs.unlink(path.join(__dirname, `../public/${data.file_path}`), (err) => {
            if (err) {
                resolve({ require: false, err: err, })
            } else {
                resolve({ require: true, })
            }
        })
    })
}

module.exports = Task