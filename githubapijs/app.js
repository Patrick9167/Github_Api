var express = require('express');
var bodyParser = require('body-parser');
var path = require('path');
var authToutes = requir('./toutes/auth-routes');
//var express-validator = require('express-validator');
var Github = require('github-api');
var app = express();
var request = require('request');
var d3 = require('d3');


var options = {
  url: 'https://api.github.com/users/patrick9167',
  headers: {
    'User-Agent': 'request'
  }
};

function callback(error, response, body) {
  if (!error && response.statusCode == 200) {
    var info = JSON.parse(body);

  }
}

request(options, callback);

//View Engine Middleware
app.set('view engine', 'ejs'); //set views to ejs
app.set('views', path.join(__dirname, 'views')); //read ejs files
app.use(express.static(path.join(__dirname, 'views')));

//Body Parser Middleware
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended: false}));

app.get('/', function(req, res){ //main output
  res.render('index');
});

app.post('/users/add', function(req, res){
  console.log(req.body.username);
});

app.listen(3000, function(){ //local host
  console.log('Server started on port 3000....');
});



//JSON parsing
// var people = [
//   {
//     name:'Patrick',
//     age: 20
//   },
// ]
//
// app.get('/', function(req, res){
//   res.json(people);
// });
