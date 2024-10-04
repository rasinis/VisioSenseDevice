import 'package:cloud_firestore/cloud_firestore.dart';

class UserDataService {
  // Reference to the Firestore collection named 'user_data'
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('user_data');

  // Method to add user data to Firestore
  Future addUserData(String uid, String firstName, String lastName,
      String email, String phoneNumber, String password) async {
    try {
      // Store the user data in Firestore under the document with the user's uid
      return await userCollection.doc(uid).set({
        'First Name': firstName,
        'Last Name': lastName,
        'Email': email,
        'Phone Number': phoneNumber,
        'Create Password': password,
        'Confirm Password': password, // Save only the create password
      });
    } catch (e) {
      print("Error adding user data: ${e.toString()}");
      return null;
    }
  }
}
