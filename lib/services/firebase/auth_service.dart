import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseFirestore firestoredb = FirebaseFirestore.instance;

  Future<String?> loginUser(String email, String password) async {
    try {
      final querySnapshot = await firestoredb
          .collection('User')
          .where('userName', isEqualTo: email)
          .where('password', isEqualTo: password)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final userData = querySnapshot.docs.first.data();

        // Devuelves el ID del documento referenciado en personId
        final DocumentReference personRef = userData['personId'];
        return personRef.id;
      } else {
        print("Correo o contraseña incorrectos");
        return null;
      }
    } catch (e) {
      print("Error al iniciar sesión: $e");
      return null;
    }
  }
}
