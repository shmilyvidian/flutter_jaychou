import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import '../lib/models/mock_model.dart';
import '../lib/models/jsonData.dart';
void main(){
  group('jsonparse test', (){
    test('mockdata test', (){
      Data data1 = Data.fromJson(json.decode(JsonString.mockdata));
      expect(data1.url, 'http://www.getdropbox.com/u/2/screencast.html');
    });
  });
}