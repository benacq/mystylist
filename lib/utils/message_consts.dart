library constants;

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const LOADER = SpinKitFadingCircle(
  color: Colors.blueAccent,
  size: 45.0,
);

//APP CORE
const String SUCCESS_MESSAGE = " You will be contacted by us very soon.";

const String ACCOUNT_BUSINESS = "business";
const String ACCOUNT_CUSTOMER = "customer";

const int TIMEOUT_SECS = 25;
const String TIMEOUT_MSG =
    "Please make ensure you have a stable internet connection";
const String TIMEOUT_TITLE = "TIMEOUT";

//FIREBASE
const String AUTH_USER_NOT_FOUND_MSG =
    "This credentials do not match with any user in our records";
const String AUTH_USER_NOT_FOUND_CODE = "user-not-found";

const String AUTH_WRONG_CREDENTIALS_MSG = "Your email or password is incorrect";
const String AUTH_WRONG_PASSWORD_CODE = "wrong-password";

const String MANY_REQUESTS_MSG =
    "We have blocked all requests from this device due to unusual activity. Try again later.";
const String MANY_REQUESTS_TITLE = "Too many requests";
const String MANY_REQUESTS_CODE = "too-many-requests";

const String AUTH_UNKNOWN_MSG =
    "Something went wrong, please ensure you have a stable connection and try again";
const String AUTH_UNKNOWN_TITLE = "Something went wrong";
const String AUTH_UNKNOWN_CODE = "unknown";

const String AUTH_INVALID_EMAIL_MSG = "Please enter a valid email address";
const String AUTH_INVALID_EMAIL_TITLE = "Invalid email";
const String AUTH_INVALID_EMAIL_CODE = "invalid-email";

const String AUTH_EMAIL_IN_USE_MSG = "This email is already in use";
const String AUTH_EMAIL_IN_USE_TITLE = "Email exists";
const String AUTH_EMAIL_IN_USE_CODE = "email-already-in-use";

const String AUTH_WEAK_PASSWORD_MSG = "Please enter a stronger password";
const String AUTH_WEAK_PASSWORD_TITLE = "Password too weak";
const String AUTH_WEAK_PASSWORD_CODE = "weak-password";

const String REQUIRE_RECENT_LOGIN_MSG =
    "Operation requires recent login, please Logout and Log back in to proceed";
const String REQUIRE_RECENT_LOGIN_TITLE = "Requires recent Login";
const int REQUIRE_RECENT_LOGIN_DURATION = 5;
const String REQUIRE_RECENT_LOGIN_CODE = "requires-recent-login";

//SHARED PREFERENCES
const String PREF_KEY_FULLNAME = "user_fullname";
const String PREF_KEY_ACC_TYPE = "account_type";
const String PREF_KEY_CUST_CONTACT = "customer_contact";
const String PREF_KEY_CUST_LOCATION = "customer_location";
const String PREF_KEY_BUSS_NAME = "business_name";
const String PREF_KEY_BUSS_CONTACT = "business_contact";
const String PREF_KEY_BUSS_LOCATION = "business_location";
const String PREF_KEY_REGION = "region";
