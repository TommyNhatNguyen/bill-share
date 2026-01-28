import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseFirestoreService {
  final FirebaseFirestore db;
  FirebaseFirestoreService() : db = FirebaseFirestore.instance;
}
