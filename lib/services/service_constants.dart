import 'dart:async';
import 'dart:io';
import 'dart:developer';

import '../errors/api_errors.dart';

const root = 'http://cloud.mobicap.co.tz:8080/';
const headers = {
  "Content-Type": "application/json",
  "Accept": "application/json"
};
const timeLimit = Duration(seconds: 5);

ApiErrors getError(var error) {
  if (error is SocketException) throw ApiErrors.socket();
  if (error is TimeoutException) throw ApiErrors.timeOut();
  throw ApiErrors.unknown();
}
