admin = require 'firebase-admin'
serviceAccount = require process.env.FIREBASE_SERVICE_ACCOUNT_KEY_JSON
request = require 'request'
_ = require 'underscore'

admin.initializeApp
  credential: admin.credential.cert(serviceAccount)
  databaseURL: process.env.FIREBASE_DATABASE_URL
admin.firestore().settings
  timestampsInSnapshots: true

request
  url: 'https://api.foursquare.com/v2/venues/categories'
  qs:
    v: '20190101'
    client_id: process.env.FOURSQUARE_CLIENT_ID
    client_secret: process.env.FOURSQUARE_CLIENT_SECRET
  json: true,
  (error, response, body) ->
    if (body.meta.code == 200)
      _.each body.response.categories, parseCategory

parseCategory = (category) ->
  admin.firestore()
    .collection 'categories'
    .doc category.id
    .set 
      name: category.name
