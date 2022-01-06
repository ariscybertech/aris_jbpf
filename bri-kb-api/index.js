const express = require("express");
const bodyParser = require("body-parser");
const cors = require("cors");
const app = express();
const port = 3001;

app.use(bodyParser.json());
app.use(
    bodyParser.urlencoded({ extended: true, })
);

app.use(cors());

app.get("/", (req, resp) => {
    resp.json({ info : "api service bri life started" })
});

var routes = require('./Routes/Route'); //importing route
routes(app); 

app.listen(port, () => {
console.log(`App running on port ${port}.`)
})

