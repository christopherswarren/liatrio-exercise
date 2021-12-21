let express = require('express');
let moment = require('moment');
let app = express();
let port = process.env.port || 8080;

app.get("/",function(request,response)
{
    response.json(
        {
            "message": "No root endpoint defined. Why not GET the /time ?"
        }
    )
})

app.get("/time",function(request,response)
{
    response.json(
        {
            "message": "Automate all the things!",
            "timestamp": moment().unix()
        }
    );
});

app.listen(port, function () {
    let datetime = new Date();
    let message = "Server running on Port:- " + port + "Started at :- " + datetime;
    console.log(message);
});
