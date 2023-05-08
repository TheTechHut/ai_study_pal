// ignore_for_file: constant_identifier_names
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:summarize_app/shared/styles/app_colors.dart';
import 'package:summarize_app/services/toast/toast_service.dart';
import 'package:summarize_app/views/pages/home/homepage.dart';
import 'package:summarize_app/views/pages/actions/mainpage.dart';
import 'package:summarize_app/views/pages/onboarding/otp_view.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class FirebaseAuthProvider extends ChangeNotifier {
  Status _status = Status.Uninitialized;

  //Widget variable
  String _username = "";

  //Control variable
  bool _isloading = false;

  //FirebaseAuth variable
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _verificationId = "";
  int? _resendToken;
  String _phoneNumber = "";
  String _errorMessage = "";

  //getters
  Status get status => _status;
  bool get isloading => _isloading;
  User get user => _auth.currentUser!;
  String get username => user.displayName!;
  String get errorMessage => _errorMessage;
  String get phoneNumber => _phoneNumber;
  Stream<User?> get authState => _auth.authStateChanges();

  // This is an example of a named constructor
  // FirebaseAuthProvider.initialize() {
  //   readPrefs();
  // }

  FirebaseAuthProvider() {
    log(_username);
  }

  Future<void> createUser({
    required String phoneNumber,
    required BuildContext context,
    required String username,
  }) async {
    try {
      _isloading = true;
      _username = username;
      notifyListeners();
      void verificationCompleted(PhoneAuthCredential phoneAuthCredential) {
        // Sign in (or link) the user with the auto-generated credential
        log("Auto Verify");
        _isloading = false;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => HomePage(userName: _username),
          ),
        );
        notifyListeners();
      }

      void verificationFailed(FirebaseAuthException authException) {
        _errorMessage =
            'Phone number verification failed: ${authException.message}';
        showToast(
          "something went wrong, Please wait and try again later",
          color: AppColor.kGrayErrorColor,
        );
        showErrorDialog(errorMessage, context);
        notifyListeners();
        return;
      }

      void codeSent(String verificationId, [int? forceResendingToken]) async {
        _verificationId = verificationId;
        _resendToken = forceResendingToken;
        _phoneNumber = phoneNumber;
        launchOTPActivity(verificationId, phoneNumber, context, username);
        log("code sent");
        notifyListeners();
      }

      void codeAutoRetrievalTimeout(String verificationId) {
        _verificationId = verificationId;
        notifyListeners();
      }

      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
        timeout: const Duration(minutes: 1),
        forceResendingToken: _resendToken,
      );
      _isloading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'An error occurred while verifying the phone number: $e';
      log(_verificationId);
      _isloading = false;
      notifyListeners();
    }
  }

  launchOTPActivity(String verificationId, String phoneNumber,
          BuildContext context, String username) =>
      showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: false,
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(16),
              child: OTPView(
                phoneNumber: phoneNumber,
                username: username,
              ),
            ),
          );
        },
      );

  Future<void> signInWithPhoneNumber(String verificationCode) async {
    try {
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: verificationCode,
      );
      final myUser = await _auth.signInWithCredential(credential);
      // Notify listeners that the user has been signed in
      User user = _auth.currentUser!;
      assert(myUser.user!.uid == user.uid);
      await user.updateDisplayName(_username);
      await user.updatePhoneNumber(credential);
      _username = user.displayName!;
      log(_username);
      _status = Status.Authenticated;
      _isloading = false;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      if (e.code.isNotEmpty) {
        log(e.code + e.message!);
      } else {
        _errorMessage =
            'An error occurred while signing in the user with phone number: ${e.message}';
      }
      _isloading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = "Unknown Error $e";
      _isloading = false;
      notifyListeners();
    }
  }

  Future<void> resendVerificationCode() async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: _phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          // Notify listeners that the user has been signed in
          notifyListeners();
        },
        verificationFailed: (FirebaseAuthException e) {
          _errorMessage =
              'An error occurred while resending the verification code: ${e.message}';
          notifyListeners();
        },
        codeSent: (String verificationId, int? resendToken) async {
          _verificationId = verificationId;
          _resendToken = resendToken;
          notifyListeners();
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
        timeout: const Duration(seconds: 60),
        forceResendingToken: _resendToken,
      );
      _isloading = false;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      _isloading = false;
      if (e.code == "session-expired") {
        //Proceed => Already logged in and probably an auth exception
        //Drawbacks Any OTP works
        //This is a work around
        //Flip side the user session has been registered on firebase
        notifyListeners();
      } else {
        _errorMessage =
            'An error occurred while resending the verification code: ${e.message}';
      }
      notifyListeners();
    } catch (e) {
      _errorMessage = "Unknown Error";
      _isloading = false;
      notifyListeners();
    }
  }

  signOut() async {
    await _auth.signOut();
  }
}
