import 'package:flutter/material.dart';
import 'package:lumiere/features/auth/data/repo/auth_repo.dart';

class Authprovider extends ChangeNotifier {
  final AuthRepo _authRepo = AuthRepo();
  bool isLoading = false;
  String? errorMassage;

  Future<void> userLogin({
    required String email,
    required String password,
  }) async {
    isLoading = true;
    errorMassage = null;
    notifyListeners();

    try {
      await _authRepo.login(email: email, password: password);
    } catch (e) {
      errorMassage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
