part of 'extensions.dart';

extension FirebaseUserExtension on FirebaseUser {
  User convertToUser({
    String name = "No Name",
    List<String> selectedGenres = const [],
    String selectedLanguage = "English",
    int balance = 50000,
  }) =>
      User(
        this.uid,
        this.email,
        name: name,
        selectedGenres: selectedGenres,
        selectedLanguage: selectedLanguage,
        balance: balance,
      );

  Future<User> fromFireStore() async => await UserServices.getUser(this.uid);
}
