library postgresql_test;

import 'package:unittest/unittest.dart';
import 'package:postgresql/postgresql.dart';

main() {
  var username = 'testdb';
  var database = 'testdb';
  var password = 'password';
  
  group('SSL Connect', () {
    
    test('SSL Connect', () {
      connect(username, database, password, requireSsl: true)
        .then(expectAsync1((c) {
          c.query("select 'fuck yeah!'").toList().then(expectAsync1((r) {
            expect(r[0][0], equals('fuck yeah!')); 
            c.close();
          }));
        }));
    });
    
  });
}

