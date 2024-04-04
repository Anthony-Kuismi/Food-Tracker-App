import '../Service/firestore_service.dart';

class HomePage {
  FirestoreService firestore = FirestoreService();

  String firstName = '';
  String lastName = '';
  int heightInInches = 0;
  double weightInPounds = 0;
  String birthDate = '';
  String gender = '';

  Future<void> fetchWaterEntry(String date) async {
    firstName = await firestore.getUserFirstName();
    lastName = await firestore.getUserLastName();
    heightInInches = await firestore.getUserHeightInInches();
    weightInPounds = await firestore.getUserWeightInPounds();
    birthDate = await firestore.getUserBirthdate();
    gender = await firestore.getUserGender();
  }
}
