part of 'services.dart';

class FlutixTransactionServices {
  static CollectionReference _transactionCollection =
      Firestore.instance.collection('transactions');

  static Future<void> saveTransaction(
      FlutixTransaction flutixTransaction) async {
    await _transactionCollection.document().setData({
      'userID': flutixTransaction.userID,
      'title': flutixTransaction.title,
      'subtitle': flutixTransaction.subtitle,
      'amount': flutixTransaction.amount,
      'time': flutixTransaction.time.millisecondsSinceEpoch,
      'picture': flutixTransaction.picture,
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
