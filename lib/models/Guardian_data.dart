import 'package:cloud_firestore/cloud_firestore.dart';

class GuardianDataService {
  final CollectionReference guardianCollection =
      FirebaseFirestore.instance.collection('guardian');

  Future addGuardianData(String uid, String firstName, String lastName,
      String Address, String phoneNumber) async {
    try {
      return await guardianCollection.doc(uid).set({
        'First Name': firstName,
        'Last Name': lastName,
        'Address': address,
        'Phone Number': phoneNumber,
      });
    } catch (e) {
      print("Error adding guardian data: ${e.toString()}");
      return null;
    }
  }
}
