
mongoose = require("mongoose")

# setup the schema, this could probably be inferred
# from the spine model eventually
ContactSchema = new mongoose.Schema
  name: String
  email: String

Contact = mongoose.model "Contact", ContactSchema

# hardcoded for now
mongoose.connect('mongodb://localhost/contacts')

express = require('express')
app = express.createServer()
app.use(express.bodyParser())

# setting up Hem manually rather than use the server option
# so we can add things to our express server
Hem = require("hem")
hem = new Hem()
app.get(hem.options.cssPath, hem.cssPackage().createServer())
app.get(hem.options.jsPath, hem.hemPackage().createServer())
app.use(express.static("./public"))

# mongoose-rest gives us restful route for our mongoose models
mongooseRest = require("mongoose-rest")
mongooseRest.use(app, mongoose)

# mount the restful routes from mongoose-rest on our server
app.get "/contacts.:format?", mongooseRest.routes().Contacts.index
app.post "/contacts", mongooseRest.routes().Contacts.create
app.get "/contacts/:contact", mongooseRest.routes().Contacts.show
app.put "/contacts/:contact", mongooseRest.routes().Contacts.update
  
app.listen(3000)

