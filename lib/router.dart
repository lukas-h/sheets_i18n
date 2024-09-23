import 'dart:io';

requestHandler(HttpRequest request) async {
  request.response.statusCode = 200;
  request.response.statusCode = await request.response.close();
}
