const express = require('express');
const app = express();
const path = require('path')
const bodyParser = require('body-parser');
const port = process.env.PORT || 4001;

const publicDir = path.join(__dirname, '/public/');
app.use(express.static(publicDir));

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

app.use((req, res, next) => {
    const origin = req.get('origin');
    res.header('Access-Control-Allow-Origin', origin);
    res.header('Access-Control-Allow-Credentials', true);
    res.header('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE');
    res.header('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept, Authorization, Cache-Control, Pragma');
    if (req.method === 'OPTIONS') {
        res.sendStatus(204);
    } else {
        next();
    }
});
app.listen(port, () => {
    console.log('API Start server at port ' + port + '.');
})

const appRouteFile = require('./routes/appRouteFile');
appRouteFile(app);

const appRouteUser = require('./routes/appRouteUser');
appRouteUser(app);

const appRouteUserType = require('./routes/appRouteUserType');
appRouteUserType(app);
