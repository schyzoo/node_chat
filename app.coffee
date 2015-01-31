app = require('express')()
http = require('http').Server(app)
io = require('socket.io')(http)
nconf = require('nconf')
config = nconf.file({file: 'config.json'})

indexCtrl = require('./controllers/index.coffee')

#configure application
app.set('view engine', 'jade')
app.set('views', __dirname + '/views')

#First consider commandline arguments and environment variables, respectively.
#nconf.argv().env();

app.get('/', (req, res) ->
  indexCtrl.view(req, res)
)

io.on('connection', (socket) ->
  console.log('a user connected')
)

http.listen(config.get('server:port'), ->
  console.log("listening on *:#{config.get('server:port')}")
)