// server.js

var express = require('express');
var app = express();
var http = require('http').Server(app); 
var io = require('socket.io')(http);    
var path = require('path');

app.get('/',function(req, res){
	  res.sendFile(__dirname + '/client.html');
	});

var count=1;
io.on('connection', function(socket){ 
  	console.log('user connected: ', socket.id);  
  	var name = "익명" + count++;                 
	socket.name = name;
  	io.to(socket.id).emit('create name', name);   
	
	socket.on('disconnect', function(){ 
	  console.log('user disconnected: '+ socket.id + ' ' + socket.name);
	});

	socket.on('send message', function(name, text){ 
		var msg = name + ' : ' + text;
		socket.name = name;
    	console.log(msg);
    	io.emit('receive message', msg);
	});
	
});

http.listen(3000, function(){ 
	console.log('server on..');
});