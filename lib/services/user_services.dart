part of 'services.dart';

class UserServices {
  static CollectionReference _userCollection =
      Firestore.instance.collection('users');

  static Future<void> updateUser(User user) async {
    _userCollection.document(user.id).setData({
      'email': user.email,
      'name': user.name,
      'selectedGenres': user.selectedGenres,
      'selectedLanguage': user.selectedLanguage,
      'balance': user.balance,
      'profilePicture': user.profilePicture ?? '',
    });
  }

  static Future<User> getUser(String id) async {
    DocumentSnapshot snapshot = await _userCollection.document(id).get();

    return User(
      id,
      snapshot.data['email'],
      name: snapshot.data['name'],
      selectedGenres: (snapshot.data['selectedGenres'] as List)
          .map((e) => e.toString())
          .toList(),
      selectedLanguage: snapshot.data['selectedLanguage'],
      balance: snapshot.data['balance'],
      profilePicture: snapshot.data['profilePicture'],
    );
  }
}
