import 'dart:convert';
import 'package:http/http.dart' as http;
import '../errors/api_errors.dart';

const headers = {
  "Content-Type": "application/json",
  "Accept": "application/json"
};
const timeLimit = Duration(seconds: 5);

Future<dynamic> get(String url) async {
  final response = await http.get(Uri.parse(url)).timeout(timeLimit);
  return json.decode(response.body);
}

///custom itemId used only for documents as the document id is found in document
///form.
///item has to be converted to json directly before passed here, as for
///documents toJson method is different (has an document-type argument). Hence
///variable name json as a reminder.
Future<dynamic> put(String url, String itemId, {required var json}) async {
  final response = await http
      .put(Uri.parse(url + '/$itemId'),
          body: json.encode(json), headers: headers)
      .timeout(timeLimit);

  return json.decode(response.body);
}

///item has to be converted to json directly before passed here, as for
///documents toJson method is different (has an document-type argument). Hence
///variable name json as a reminder.
Future<dynamic> post(String url, {required var json}) async {
  final response = await http
      .post(Uri.parse(url), body: json.encode(json), headers: headers)
      .timeout(timeLimit);

  return json.decode(response.body);
}

Future<dynamic> delete(String url, String itemId) async {
  final response =
      await http.delete(Uri.parse(url + '/$itemId')).timeout(timeLimit);

  _handleStatusCodes(response.statusCode);

  return json.decode(response.body);
}

void _handleStatusCodes(int statusCode) {
  if (statusCode == 200) return;
  if (statusCode == 400) throw ApiErrors.invalidDelete();
  throw ApiErrors.unknown();
}
