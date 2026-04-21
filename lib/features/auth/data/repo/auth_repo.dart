import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lumiere/features/auth/data/models/user.dart';

class AuthRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> SignUp({
    required String email,
    required String name,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      UserModel newUser = UserModel(
        uId: userCredential.user!.uid,
        name: name,
        email: email,
        createAt: DateTime.now(),
      );

      await _firestore
          .collection("users")
          .doc(newUser.uId)
          .set(newUser.toMap());
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? "فشل انشاء الحساب ");
    } catch (e) {
      throw Exception("حدث خطا اثناء حفظ البيانات");
    }
  }

  Future<void> login({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? "فشل تسجيل الدخول");
    }
  }

  Future<void> resetPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? "فشل التحقق من الايميل");
    }
  }

  Future<void> signInwithGoogle() async {
    try {
      final GoogleSignInAccount? googleuser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleuser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );
      if (userCredential.additionalUserInfo!.isNewUser) {
        UserModel newUser = UserModel(
          uId: userCredential.user!.uid,
          name: userCredential.user!.displayName ?? "User",
          email: userCredential.user!.email ?? "",
          createAt: DateTime.now(),
        );
        await _firestore
            .collection("users")
            .doc(newUser.uId)
            .set(newUser.toMap());
      }
    } catch (e) {
      throw Exception(e.toString());
    } catch (e) {
      throw Exception("فشل التسجيل باستخدام حساب قوقل ");
    }
  }

  Future<void> SignOut() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? "فشل عملية تسجيل الخروج");
    }
  }

  User? getCureeuntUser() {
    return FirebaseAuth.instance.currentUser;
  }
}
