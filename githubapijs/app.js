var express = require('express');
var bodyParser = require('body-parser');
var path = require('path');
var Github = require('github-api');
var app = express();
var request = require('request');
var d3 = require('d3');
var fs = require('fs');


fs.truncate('views/rand.csv', 0, function(){});// clear file

function formatFrequency(data) {
  var langs=[];
  var count=[];
  var indicator = 0;
  var j=0;
  for(var i=0; i<data.length; i++)
  {
    indicator=0;
    j=0;
    while(langs[j]!=null)
    {
      if(langs[j]==data[i].language)
      {
        indicator=1;
        count[j]++;
      }
      j++;
    }
    if(indicator==0)
    {
      langs.push(data[i].language);
      count.push(1);
    }
  }

  for(var k = 0; k<langs.length; k++)
  {
    fs.appendFile('views/rand.csv', JSON.stringify(langs[k])+", " + (count[k])+ "\n", function(err) {
    if(err) {
        console.log('there was an error: ', err);
        return;
    }
    console.log('data was appended to file');
  });
}

}

// app.post('/graph', function(req, res){
//   //console.log(req.body.org);
// });

var options = {
  url: 'https://api.github.com/orgs/facebook/repos',
  headers: {
    'User-Agent': 'request',
    'Authorization':'token 247c38033b2093118936af82c8ccd9f8f316f278'
  }
};

function callback(error, response, body) {
  if (!error && response.statusCode == 200) {
    var info = JSON.parse(body);
    fs.appendFile('views/rand.csv', "id,value\n", function(){});//csv file requirements
    formatFrequency(info);
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
  res.render('main.ejs');
});

app.get('/graph', function(req, res){ //main output
  res.render('index.ejs');
});

app.listen(3000, function(){ //local host
  console.log('Server started on port 3000....');
});
