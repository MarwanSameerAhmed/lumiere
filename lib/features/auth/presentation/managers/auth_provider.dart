import 'package:flutter/material.dart';
import 'package:lumiere/features/auth/data/repo/auth_repo.dart';

class Authprovider extends ChangeNotifier {
  final AuthRepo _authRepo = AuthRepo();
  bool isLoading = false;
  String? errorMassage;

  Future<bool> userLogin({
    required String email,
    required String password,
  }) async {
    isLoading = true;
    errorMassage = null;
    notifyListeners();

    try {
      await _authRepo.login(email: email, password: password);
      return true;
    } catch (e) {
      errorMassage = e.toString();
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> userSignUp({
    required String name,
    required String email,
    required String password,
  }) async {
    isLoading = true;
    errorMassage = null;
    notifyListeners();
    try {
      await _authRepo.SignUp(email: email, name: name, password: password);
      return true;
    } catch (e) {
      errorMassage = e.toString();
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> userSignInWithGoogle() async {
    isLoading = true;
    errorMassage = null;
    notifyListeners();
    try {
      await _authRepo.signInwithGoogle();
      return true;
    } catch (E) {
      errorMassage = E.toString();
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> userResetpassword({required String email}) async {
    isLoading = true;
    errorMassage = null;
    notifyListeners();
    try {
      await _authRepo.resetPassword(email: email);
      return true;
    } catch (e) {
      errorMassage = e.toString();
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
