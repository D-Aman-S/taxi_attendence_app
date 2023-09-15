import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:cache/cache.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:meta/meta.dart';

/// {@template sign_in_with_phone_failure}
/// Thrown during the phone send otp processs if a failure occurs.
/// {@endtemplate}
class PhoneLoginFailure implements Exception {
  /// {@macro sign_in_with_phone_failure}
  const PhoneLoginFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory PhoneLoginFailure.fromCode(String code) {
    switch (code) {
      case "invalid-phone-number":
        return const PhoneLoginFailure(
          'The provided phone number is not valid.',
        );

      case "ERROR_EMAIL_ALREADY_IN_USE":
      case "account-exists-with-different-credential":
      case "email-already-in-use":
        return const PhoneLoginFailure(
          "Email already used. Go to login page.",
        );

      case "ERROR_WRONG_PASSWORD":
      case "wrong-password":
        return const PhoneLoginFailure(
          "Wrong email/password combination.",
        );

      case "ERROR_USER_NOT_FOUND":
      case "user-not-found":
        return const PhoneLoginFailure(
          "No user found with this email.",
        );

      case "ERROR_USER_DISABLED":
      case "user-disabled":
        return const PhoneLoginFailure(
          "User disabled.",
        );

      case "ERROR_TOO_MANY_REQUESTS":
      case "too-many-requests":
      case "operation-not-allowed":
        return const PhoneLoginFailure(
          "Too many requests to log into this account.",
        );

      case "ERROR_OPERATION_NOT_ALLOWED":
      case "operation-not-allowed":
        return const PhoneLoginFailure(
          "Server error, please try again later.",
        );

      case "ERROR_INVALID_EMAIL":
      case "invalid-email":
        return const PhoneLoginFailure(
          "Email address is invalid.",
        );

      default:
        return PhoneLoginFailure(code);
    }
  }

  /// The associated error message.
  final String message;
}

/// Thrown during the logout process if a failure occurs.
class LogOutFailure implements Exception {}

/// {@template authentication_repository}
/// Repository which manages user authentication.
/// {@endtemplate}
class AuthenticationRepository {
  /// {@macro authentication_repository}
  AuthenticationRepository({
    CacheClient? cache,
    firebase_auth.FirebaseAuth? firebaseAuth,
  })  : _cache = cache ?? CacheClient(),
        _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  final CacheClient _cache;
  final firebase_auth.FirebaseAuth _firebaseAuth;

  /// Whether or not the current environment is web
  /// Should only be overridden for testing purposes. Otherwise,
  /// defaults to [kIsWeb]
  @visibleForTesting
  bool isWeb = kIsWeb;

  /// User cache key.
  /// Should only be used for testing purposes.
  @visibleForTesting
  static const userCacheKey = '__user_cache_key__';

  /// Stream of [User] which will emit the current user when
  /// the authentication state changes.
  ///
  /// Emits [User.empty] if the user is not authenticated.
  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null ? User.empty : firebaseUser.toUser;
      _cache.write(key: userCacheKey, value: user);
      return user;
    });
  }

  ///verification id we get from callbacks
  String _verificationId = "";

  ///credentials after verifcation has been completed
  firebase_auth.PhoneAuthCredential _credential =
      firebase_auth.PhoneAuthProvider.credential(
          verificationId: "", smsCode: "");

  ///USER credentials
  late firebase_auth.UserCredential _userCredential;

  /// Returns the current cached user.
  /// Defaults to [User.empty] if there is no cached user.
  User get currentUser {
    return _cache.read<User>(key: userCacheKey) ?? User.empty;
  }

  /// Signs in with Phone Number.
  ///
  /// Throws a [PhoneLoginFailure] if an exception occurs.
  Future<void> sendOtp({
    required String phoneNumber,
  }) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: "+91$phoneNumber",
        codeSent: (verificationId, forceResendingToken) {
          _verificationId = verificationId;
        },
        verificationCompleted: (phoneAuthCredential) {
          _credential = phoneAuthCredential;
        },
        verificationFailed: (e) {
          throw PhoneLoginFailure.fromCode(e.code);
        },
        codeAutoRetrievalTimeout: (verificationId) {
          _verificationId = verificationId;
        },
      );
    } catch (_) {
      throw const PhoneLoginFailure();
    }
  }

  Future<void> verifyOTP(String otp) async {
    try {
      _credential = await firebase_auth.PhoneAuthProvider.credential(
          verificationId: _verificationId, smsCode: otp);
    } catch (e) {
      throw PhoneLoginFailure.fromCode(e.toString());
    }
  }

  Future<void> signIn() async {
    try {
      _userCredential = await _firebaseAuth.signInWithCredential(_credential);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw PhoneLoginFailure.fromCode(e.code);
    } catch (_) {
      throw const PhoneLoginFailure();
    }
  }

  /// Signs out the current user which will emit
  /// [User.empty] from the [user] Stream.
  ///
  /// Throws a [LogOutFailure] if an exception occurs.
  Future<void> logOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
      ]);
    } catch (_) {
      throw LogOutFailure();
    }
  }
}

extension on firebase_auth.User {
  /// Maps a [firebase_auth.User] into a [User].
  User get toUser {
    return User(id: uid, phoneNumber: phoneNumber);
  }
}
