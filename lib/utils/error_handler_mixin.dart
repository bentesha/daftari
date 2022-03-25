import 'dart:async';
import 'dart:io';
import 'dart:developer';

import '../errors/api_errors.dart';

mixin ErrorHandler {
  ApiErrors getError(var error) {
    log(error.toString());
    if (error is SocketException) throw ApiErrors.socket();
    if (error is TimeoutException) throw ApiErrors.timeOut();
    throw ApiErrors.unknown();
  }
}
