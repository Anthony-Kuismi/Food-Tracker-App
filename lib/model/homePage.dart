import '../Service/FirestoreService.dart';

class HomePage {
  FirestoreService firestore = FirestoreService();
  Future<void> fetch() async{
    return Future.value(["Default data"]);
  }
}