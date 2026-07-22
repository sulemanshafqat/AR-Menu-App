import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../services/auth_service.dart';
import '../services/user_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final UserService _userService = UserService();

  User? _user;
  UserModel? _userModel;

  bool _isLoading = false;

  User? get user => _user;
  UserModel? get userModel => _userModel;

  bool get isLoading => _isLoading;
  bool get isLoggedIn => _user != null;

  AuthProvider() {
    _authService.authState.listen((firebaseUser) async {
      _user = firebaseUser;

      if (_user != null) {
        _userModel = await _userService.getUser(_user!.uid);
      } else {
        _userModel = null;
      }

      notifyListeners();
    });
  }

  Future<String?> register({
    required String fullName,
    required String email,
    required String password,
    required String phone,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _authService.register(
        fullName: fullName,
        email: email,
        password: password,
        phone: phone,
      );

      if (_authService.currentUser != null) {
        _userModel = await _userService.getUser(
          _authService.currentUser!.uid,
        );
      }

      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _authService.login(
        email: email,
        password: password,
      );

      if (_authService.currentUser != null) {
        _userModel = await _userService.getUser(
          _authService.currentUser!.uid,
        );
      }

      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await _authService.logout();
    _userModel = null;
  }
}