express = require 'express'

# Web Server section of system
app = module.exports = express.createServer()

# Web server configuration
app.configure ()->
  app.set('views', __dirname + '/views')
  app.set('view engine', 'ejs')
  app.use(express.cookieParser())
  app.use(express.bodyParser())
  app.use(app.router)
  return app.use(express["static"](__dirname + "/public"))

# @Description: The inteface where users input their json object to see json output
app.get '/', (req, res)->
  res.render 'home_page', locals :
    host: "localhost"
    port: 9700


# Start web server
port = process.argv[2] || 9700
app.listen port
console.log 'socket server started on', port

io = require('socket.io').listen(app, { log: false })

io.sockets.on 'connection', (socket)->

  socket.emit 'connected', { status: 'success' }
  socket.on 'disconnect', ()=>

  socket.on 'start checking', (profile_info)=>
    console.log profile_info
    socket.emit 'record found',
      offense_name: "BMV moment"
      offense_date: new Date()
      offense_county: "Santa Clara"
      offense_degree: 10