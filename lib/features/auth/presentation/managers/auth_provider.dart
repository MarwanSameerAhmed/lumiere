import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lumiere/features/auth/data/models/user.dart';
import 'package:lumiere/features/auth/data/repo/auth_repo.dart';

class Authprovider extends ChangeNotifier {
  final AuthRepo _authRepo = AuthRepo();
  bool isLoading = false;
  String? errorMassage;
  UserModel? user;

  Future<bool> userLogin({
    required String email,
    required String password,
  }) async {
    isLoading = true;
    errorMassage = null;
    notifyListeners();

    try {
      await _authRepo.login(email: email, password: password);
      String? uid = _authRepo.getCureeuntUser()!.uid;
      if (uid != null) {
        await _authRepo.SaveTokenDevice(uid);
      }
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
      String? uid = _authRepo.getCureeuntUser()!.uid;
      if (uid != null) {
        await _authRepo.SaveTokenDevice(uid);
      }
      return true;
    } catch (e) {
      errorMassage = e.toString();
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> loadCurrentUser() async {
    String? Uid = FirebaseAuth.instance.currentUser?.uid;
    if (Uid == null) return false;
    try {
      isLoading = true;
      notifyListeners();
      user = await _authRepo.getUserData(Uid);
      return true;
    } catch (e) {
      errorMassage = e.toString();
      notifyListeners();
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
      String? uid = _authRepo.getCureeuntUser()!.uid;
      if (uid != null) {
        await _authRepo.SaveTokenDevice(uid);
      }
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

  bool CheckCurruntUser() {
    final user = _authRepo.getCureeuntUser();
    return user != null;
  }

  Future<String> getUserRoleProvider() async {
    isLoading = true;
    errorMassage = null;
    notifyListeners();
    try {
      String? uid = _authRepo.getCureeuntUser()!.uid;
      String role = await _authRepo.getUserRole(uid);
      return role;
    } catch (e) {
      errorMassage = e.toString();
      notifyListeners();
      return 'user';
    } finally {
      notifyListeners();
    }
  }

  Future<bool> signout() async {
    isLoading = true;
    errorMassage = null;
    notifyListeners();
    try {
      await _authRepo.SignOut();
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
