admin = require 'firebase-admin'
serviceAccount = require process.env.FIREBASE_SERVICE_ACCOUNT_KEY_JSON

admin.initializeApp
  credential: admin.credential.cert(serviceAccount)
  databaseURL: process.env.FIREBASE_DATABASE_URL
