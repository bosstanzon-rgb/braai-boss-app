const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

exports.paystackWebhook = functions.https.onRequest(async (req, res) => {
  const event = req.body;

  // 1. Paystack tells us the payment worked
  if (event.event === 'charge.success') {
    const userEmail = event.data.customer.email;
    
    // 2. We find that person in Firestore and make them a PRO BOSS
    const userQuery = await admin.firestore().collection('users')
      .where('email', '==', userEmail).get();

    if (!userQuery.empty) {
      const userDoc = userQuery.docs[0].ref;
      await userDoc.update({
        isPro: true,
        recipeCount: 0
      });
    }
  }
  res.status(200).send('Success');
});