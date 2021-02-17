part of 'services.dart';

class FlutixTransactionServices {
  static CollectionReference _transactionCollection =
      Firestore.instance.collection('transactions');

  static Future<void> saveTransaction(FlutixTransaction transaction) async {
    await _transactionCollection.document().setData({
      'userID': transaction.userID,
      'title': transaction.title,
      'subtitle': transaction.subtitle,
      'amount': transaction.amount,
      'time': transaction.time.millisecondsSinceEpoch,
      'picture': transaction.picture,
    });
  }

  static Future<List<FlutixTransaction>> getTransactions(String userID) async {
    QuerySnapshot snapshot = await _transactionCollection.getDocuments();
    var documents = snapshot.documents
        .where((document) => document.data['userID'] == userID);

    return documents
        .map((document) => FlutixTransaction(
              userID: document.data['userID'],
              title: document.data['title'],
              subtitle: document.data['subtitle'],
              amount: document.data['amount'],
              time: DateTime.fromMillisecondsSinceEpoch(document.data['time']),
              picture: document.data['picture'],
            ))
        .toList();
  }
}
