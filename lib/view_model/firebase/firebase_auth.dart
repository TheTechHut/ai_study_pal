// ignore_for_file: constant_identifier_names
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:summarize_app/views/core/homepage.dart';
import 'package:summarize_app/views/onboarding/otp_view.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class FirebaseAuthProvider extends ChangeNotifier {
  Status _status = Status.Uninitialized;
  //Shared Preferences variable
  final String _prefsIsLoggedIN = "isLoggedIn";
  final String _prefsUsername = "USERNAME";
  late SharedPreferences _prefs;
  //Widget variable
  String _username = "";

  //Control variable
  bool _isloggedIn = false;
  bool _isloading = false;

  //FirebaseAuth variable
  User? _user;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _verificationId = "";
  int? _resendToken;
  String _phoneNumber = "";
  String _errorMessage = "";

  //getters
  Status get status => _status;
  bool get isloggedIn => _isloggedIn;
  bool get isloading => _isloading;
  User get user => _user!;
  String get username => _username;
  String get errorMessage => _errorMessage;
  String get phoneNumber => _phoneNumber;
  // This is an example of a named constructor
  FirebaseAuthProvider.initialize() {
    readPrefs();
  }

  Future<void> readPrefs() async {
    await Future.delayed(const Duration(seconds: 3)).then(
      (v) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        _isloggedIn = prefs.getBool(_prefsIsLoggedIN) ?? false;
        _isloading = true;
        if (_isloggedIn) {
          _user = _auth.currentUser;
          assert(_user != null);
          _username = prefs.getString(_prefsUsername) ?? "";
          log(_user!.displayName.toString());
          _status = Status.Authenticated;
          _isloading = false;
          notifyListeners();
          return;
        }

        _status = Status.Unauthenticated;
        _isloading = false;
        notifyListeners();
      },
    );
  }

  FirebaseAuthProvider() {
    _isloading = false;
    _errorMessage = '';
    _prefs = SharedPreferences.getInstance() as SharedPreferences;
  }

  Future<void> createUser({
    required String phoneNumber,
    required BuildContext context,
    required String username,
  }) async {
    try {
      _isloading = true;
      notifyListeners();
      void verificationCompleted(
          PhoneAuthCredential phoneAuthCredential) async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(userName: username),
          ),
        );
        await _auth.signInWithCredential(phoneAuthCredential);
        _prefs.setString(_prefsUsername, username);
        _isloading = false;
        notifyListeners();
      }

      void verificationFailed(FirebaseAuthException authException) {
        _errorMessage =
            'Phone number verification failed: ${authException.message}';
        notifyListeners();
      }

      void codeSent(String verificationId, [int? forceResendingToken]) async {
        _verificationId = verificationId;
        _resendToken = forceResendingToken;
        _phoneNumber = phoneNumber;
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
        timeout: const Duration(minutes: 2),
        forceResendingToken: _resendToken,
      );
      log(_verificationId);
      _username = username;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'An error occurred while verifying the phone number: $e';
      log(_verificationId);
      notifyListeners();
    }
  }

  // Future<void> createUser(
  //     String phoneNumber, BuildContext context, String username) async {
  //   try {
  //     _isloading = true;
  //     notifyListeners();
  //     verificationCompleted(PhoneAuthCredential phoneAuthCredential) async {
  //       String code = phoneAuthCredential.smsCode!;
  //       if (code.isNotEmpty) {
  //         // await _auth.signInWithCredential(phoneAuthCredential).whenComplete(
  //         //       () =>
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => HomePage(userName: username),
  //           ),
  //         );
  //         //);
  //         // final prefs = await SharedPreferences.getInstance();
  //         // prefs.setString(_prefsUsername, username);
  //         log(code);
  //         notifyListeners();
  //       }
  //       // Notify listeners that the user has been signed in
  //       //Automatic sign in
  //       _isloading = false;
  //       notifyListeners();
  //     }

  //     verificationFailed(FirebaseAuthException authException) {
  //       _errorMessage =
  //           'Phone number verification failed: ${authException.message}';
  //       notifyListeners();
  //     }

  //     codeSent(String verificationId, [int? forceResendingToken]) async {
  //       //Where I should launch the UI to enter verification code
  //       //Automatic sign in has failed
  //       //The resend token is null for IOS
  //       //Enter the verification code and begin the authentication
  //       //Make a phone credential object to sign in the user
  //       _verificationId = verificationId;
  //       _resendToken = forceResendingToken;
  //       _phoneNumber = phoneNumber;
  //       launchOTPActivity(verificationId, phoneNumber, context, username);
  //       notifyListeners();
  //     }

  //     codeAutoRetrievalTimeout(String verificationId) {
  //       _verificationId = verificationId;
  //       notifyListeners();
  //     }

  //     await _auth.verifyPhoneNumber(
  //       phoneNumber: phoneNumber,
  //       verificationCompleted: verificationCompleted,
  //       verificationFailed: verificationFailed,
  //       codeSent: codeSent,
  //       codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
  //       timeout: const Duration(minutes: 2),
  //       forceResendingToken: _resendToken,
  //     );
  //     log(_verificationId);
  //     _username = username;
  //     notifyListeners();
  //   } catch (e) {
  //     _errorMessage = 'An error occurred while verifying the phone number: $e';
  //     log(_verificationId);
  //     notifyListeners();
  //   }
  // }

  launchOTPActivity(String verificationId, String phoneNumber,
          BuildContext context, String username) =>
      showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: false,
        context: context,
        builder: (context) {
          final MediaQueryData mediaQueryData = MediaQuery.of(context);
          return Padding(
            padding: EdgeInsets.only(bottom: mediaQueryData.viewInsets.bottom),
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
      User currentUser = _auth.currentUser!;
      assert(myUser.user!.uid == currentUser.uid);
      await currentUser.updateDisplayName(_username);
      await currentUser.updatePhoneNumber(credential);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool(_prefsIsLoggedIN, true);
      prefs.setString(_prefsUsername, currentUser.displayName!);
      _isloggedIn = true;
      _isloading = false;
      _status = Status.Authenticated;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'An error occurred while signing in: $e';
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
      notifyListeners();
    } catch (e) {
      _errorMessage =
          'An error occurred while resending the verification code: $e';
      notifyListeners();
    }
  }
}
