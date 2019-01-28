# Foursquare Categories for Cloud Firestore
This application will import Foursquare categories into a collection on Cloud Firestore, enabling mobile apps developed with Firebase to use Foursquare categories.

## Getting Started
Use `npm start` to initiate the import, or use your PaaS of choice.  Ensure that you specify the following environmental variables:

`FIREBASE_SERVICE_ACCOUNT_KEY_JSON` - path to your Firebase service account key JSON

`FIREBASE_DATABASE_URL` - URL for your Firebase database

`FOURSQUARE_CLIENT_ID` - client ID of your Foursquare Developers app

`FOURSQUARE_CLIENT_SECRET` - client secret of your Foursquare Developers app

## Links
- https://developer.foursquare.com/docs/resources/categories
- https://firebase.google.com/docs/firestore/
