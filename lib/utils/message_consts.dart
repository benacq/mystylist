library constants;

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

//Its being used around 3 places thats why i have brought it here
const LOADER = SpinKitFadingCircle(
  color: Colors.blueAccent,
  size: 45.0,
);

const int TIMEOUT_SECS = 14;

const String SUCCESS_MESSAGE = " You will be contacted by us very soon.";

const String USER_ACCOUNT_BUSINESS = "business";
const String USER_ACCOUNT_CUSTOMER = "customer";

const String TIMEOUT_MESSAGE =
    "Please make sure you have a stable internet connection";
const String TIMEOUT_TITLE = "REQUEST TIMEOUT";

const String USER_NOT_FOUND_MESSAGE =
    "This credentials do not match with any user in our records";

const String WRONG_CREDENTIALS_MESSAGE = "Your email or password is incorrect";

const String TOO_MANY_REQUESTS_MESSAGE =
    "We have blocked all requests from this device due to unusual activity. Try again later.";
const String TOO_MANY_REQUESTS_TITLE = "TOO MANY REQUESTS";

const String NO_CONNECTION_MESSAGE =
    "Failed to establish connection, please ensure you have a stable connection and try again";
const String NO_CONNECTION_TITLE = "CONNECTION FAILED";

const String PREF_KEY_FULLNAME = "user_fullname";
const String PREF_KEY_ACC_TYPE = "account_type";
const String PREF_KEY_CUST_CONTACT = "customer_contact";
const String PREF_KEY_CUST_LOCATION = "customer_location";
const String PREF_KEY_BUSS_NAME = "business_name";
const String PREF_KEY_BUSS_CONTACT = "business_contact";
const String PREF_KEY_BUSS_LOCATION = "business_location";
const String PREF_KEY_REGION = "region";

