import * as admin from 'firebase-admin'
import * as fs from 'fs'
// import * as functions from 'firebase-functions'

admin.initializeApp({
  storageBucket: 'flutter-web-experiment.appspot.com'
})

const firestore = admin.firestore()

export async function upload(): Promise<void> {
  const dir = '../../../SheepHomework/stamp/outputs/stamps/'
  const files = fs.readdirSync(dir).filter(x => x.endsWith('.png'))
  console.log(files)
  const batch = firestore.batch()
  const ref = firestore.collection('stamps')
  for (const f of files) {
    const key = f.replace('.png', '')
    batch.set(ref.doc(key), {
      name: key,
      imageUrl: `https://firebasestorage.googleapis.com/v0/b/flutter-web-experiment.appspot.com/o/stamps%2F${f}?alt=media`
    })
  }
  await batch.commit()
}
