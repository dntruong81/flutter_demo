import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // [CREATE] ĐĂNG KÝ TÀI KHOẢN MỚI
  Future<bool> register({required String email, required String password, required String name}) async {
    try {
      var userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        await firebaseAuth.currentUser!.updateDisplayName(name);
        //await firebaseAuth.currentUser!.reload(); // Ép nạp lại dữ liệu tên lên bộ nhớ máy
        return true;
      }
      return false;
    } catch (e) {
      rethrow;
    }
  }

  // [READ] ĐĂNG NHẬP TÀI KHOẢN
  Future<bool> signIn({required String email, required String password}) async {
    try {
      var userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        //await firebaseAuth.currentUser!.reload(); // Đảm bảo đồng bộ tên mới nhất từ server về máy
        return true;
      }
      return false;
    } catch (e) {
      rethrow;
    }
  }

  // [DELETE SYSTEM SESSION] ĐĂNG XUẤT
  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      rethrow;
    }
  }
}
