import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';
import 'user_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserService _userService = UserService();

  User? get currentUser => _auth.currentUser;

  Stream<User?> get authState => _auth.authStateChanges();

  Future<UserCredential> register({
    required String fullName,
    required String email,
    required String password,
    required String phone,
  }) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = UserModel(
      uid: credential.user!.uid,
      fullName: fullName,
      email: email,
      phone: phone,
      role: "customer",
      profileImage: "",
      createdAt: DateTime.now(),
    );

    await _userService.createUser(user);

    return credential;
  }

  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}