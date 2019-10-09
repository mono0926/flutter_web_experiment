import * as admin from 'firebase-admin'
import * as functions from 'firebase-functions'

admin.initializeApp({})

export const helloWorld = functions
  .region('asia-northeast1')
  .https.onRequest(async (request, response) => {
    // console.log(`app: ${admin.instanceId().app.options.projectId}`)
    const testsSnapshot = await admin
      .firestore()
      .collection('tests')
      .get()
    console.log(testsSnapshot.docs.length)
    response.send('hello')
  })
