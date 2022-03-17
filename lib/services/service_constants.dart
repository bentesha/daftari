import 'dart:async';
import 'dart:io';

import '../errors/api_errors.dart';

const root = 'http://cloud.mobicap.co.tz:8080/';
const headers = {
  "Content-Type": "application/json",
  "Accept": "application/json"
};
const timeLimit = Duration(seconds: 5);

ApiErrors getError(var error) {
  switch (error) {
    case SocketException:
      throw ApiErrors.socket();
    case TimeoutException:
      throw ApiErrors.timeOut();
    default:
      throw ApiErrors.unknown();
  }
}
