
mongoose = require("mongoose")

# hardcoded for now
mongoose.connect('mongodb://localhost/contacts')

express = require('express')
app = express.createServer()
app.use(express.bodyParser())
app.use(express.logger())

# setting up Hem manually rather than use the server option
# so we can add things to our express server
Hem = require("hem")
hem = new Hem()
app.get(hem.options.cssPath, hem.cssPackage().createServer())
app.get(hem.options.jsPath, hem.hemPackage().createServer())
app.use(express.static("./public"))

# mongoose-rest gives us restful route for our mongoose models
# mongooseRest = require("mongoose-rest")
# mongooseRest.use(app, mongoose)

require "spine/lib/ajax"
Contact = require("./app/models/contact")

SpineGoose = require("spinegoose")
spineGoose = new SpineGoose
  app: app
  mongoose: mongoose
  models: [Contact]

app.listen(3000)

