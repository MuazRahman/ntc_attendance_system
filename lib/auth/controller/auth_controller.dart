import 'package:get/get.dart';
import 'package:ntc_sas/common/widgets/show_snack_bar_message.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController extends GetxController {
  final RxBool isBusy = false.obs;
  final RxnString userEmail = RxnString();

  @override
  void onInit() {
    super.onInit();
    final session = Supabase.instance.client.auth.currentSession;
    userEmail.value = session?.user.email;
  }

  Future<bool> login({required String email, required String password}) async {
    if (email.isEmpty || password.isEmpty) {
      showSnackBarMessage(subtitle: 'Email and password are required', isErrorMessage: true);
      return false;
    }
    isBusy.value = true;
    try {
      final response = await Supabase.instance.client.auth.signInWithPassword(email: email, password: password);
      if (response.session != null && response.user != null) {
        userEmail.value = response.user!.email;
        showSnackBarMessage(subtitle: 'Login successful', isErrorMessage: false);
        return true;
      }
      showSnackBarMessage(subtitle: 'Invalid credentials', isErrorMessage: true);
      return false;
    } on AuthException catch (e) {
      showSnackBarMessage(subtitle: e.message, isErrorMessage: true);
      return false;
    } catch (_) {
      showSnackBarMessage(subtitle: 'Something went wrong. Try again.', isErrorMessage: true);
      return false;
    } finally {
      isBusy.value = false;
    }
  }

  Future<bool> signup({required String email, required String password}) async {
    if (email.isEmpty || password.isEmpty) {
      showSnackBarMessage(subtitle: 'Email and password are required', isErrorMessage: true);
      return false;
    }
    isBusy.value = true;
    try {
      final response = await Supabase.instance.client.auth.signUp(email: email, password: password);
      if (response.user != null) {
        showSnackBarMessage(subtitle: 'Signup successful. Please login.', isErrorMessage: false);
        return true;
      }
      showSnackBarMessage(subtitle: 'Signup failed. Try again.', isErrorMessage: true);
      return false;
    } on AuthException catch (e) {
      showSnackBarMessage(subtitle: e.message, isErrorMessage: true);
      return false;
    } catch (_) {
      showSnackBarMessage(subtitle: 'Something went wrong. Try again.', isErrorMessage: true);
      return false;
    } finally {
      isBusy.value = false;
    }
  }

  Future<void> logout() async {
    try {
      await Supabase.instance.client.auth.signOut();
      userEmail.value = null;
      showSnackBarMessage(subtitle: 'Logged out', isErrorMessage: false);
    } catch (_) {
      showSnackBarMessage(subtitle: 'Could not logout. Try again.', isErrorMessage: true);
    }
  }

  Future<bool> updatePassword({required String newPassword}) async {
    if (newPassword.isEmpty) {
      showSnackBarMessage(subtitle: 'Password cannot be empty', isErrorMessage: true);
      return false;
    }
    isBusy.value = true;
    try {
      await Supabase.instance.client.auth.updateUser(UserAttributes(password: newPassword));
      showSnackBarMessage(subtitle: 'Password updated', isErrorMessage: false);
      return true;
    } on AuthException catch (e) {
      showSnackBarMessage(subtitle: e.message, isErrorMessage: true);
      return false;
    } catch (_) {
      showSnackBarMessage(subtitle: 'Could not update password', isErrorMessage: true);
      return false;
    } finally {
      isBusy.value = false;
    }
  }
}


