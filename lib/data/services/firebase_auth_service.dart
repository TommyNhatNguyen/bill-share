import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth firebaseAuth;
  FirebaseAuthService() : firebaseAuth = FirebaseAuth.instance;
}
