admin = require 'firebase-admin'
serviceAccount = require process.env.FIREBASE_SERVICE_ACCOUNT_KEY_JSON
request = require 'request'
_ = require 'underscore'

admin.initializeApp
  credential: admin.credential.cert(serviceAccount)
  databaseURL: process.env.FIREBASE_DATABASE_URL
firestore = admin.firestore()
firestore.settings
  timestampsInSnapshots: true

CATEGORY_COLLECTION_ID = 'categories'

parseCategory = (category, level, parents = {}) ->
  subcategories = _.map category.categories, (subcategory) ->
    subParents = _.clone parents
    subParents['level' + level] = firestore.doc CATEGORY_COLLECTION_ID + '/' + category.id
    parseCategory subcategory, level + 1, subParents
    firestore.doc CATEGORY_COLLECTION_ID + '/' + subcategory.id
 
  firestore
    .collection CATEGORY_COLLECTION_ID
    .doc category.id
    .set
      name: category.name
      name_plural: category.pluralName
      level: level
      subcategories: subcategories
      parents: parents

request
  url: 'https://api.foursquare.com/v2/venues/categories'
  qs:
    v: '20190101'
    client_id: process.env.FOURSQUARE_CLIENT_ID
    client_secret: process.env.FOURSQUARE_CLIENT_SECRET
  json: true,
  (error, response, body) ->
    if (body.meta.code == 200)
      _.each body.response.categories, (category) ->
        parseCategory category, 1
