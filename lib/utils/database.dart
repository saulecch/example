import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('users');

class Database {
  static Future<void> addUser({
    required String fullName,
    required String company,
    required String age,
  }) async {
    DocumentReference documentReferencer = _mainCollection.doc();

    Map<String, dynamic> data = <String, dynamic>{
      "full_name": fullName,
      "company": company,
      "age": age,
    };

    await documentReferencer
        .set(data)
        .whenComplete(() => print("El usuario se añadió"))
        .catchError((e) => print(e));
  }

  static Future<void> updateUser({
    required String fullName,
    required String company,
    required String age,
    required String docId,
  }) async {
    DocumentReference documentReference = _mainCollection.doc(docId);
    Map<String, dynamic> data = <String, dynamic>{
      "full_name": fullName,
      "company": company,
      "age": age,
    };
    await documentReference
        .update(data)
        .whenComplete(() => print('El usuario se actualizó'))
        .catchError((error) => print(error));
  }

  static Future<void> deleteUser({
    required String docId,
  }) async {
    DocumentReference documentReferencer = _mainCollection.doc(docId);

    await documentReferencer
        .delete()
        .whenComplete(() => print('El usuario se eliminó'))
        .catchError((e) => print(e));
  }
}
