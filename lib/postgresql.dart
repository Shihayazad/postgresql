library postgresql;

import 'dart:async';
import 'dart:collection';
import 'dart:crypto';
import 'dart:io';
import 'dart:utf' show encodeUtf8, decodeUtf8;

part 'buffer.dart';
part 'connection.dart';
part 'constants.dart';
part 'message_buffer.dart';
part 'query.dart';
part 'settings.dart';

//FIXME Just for hacking
//part 'private_test.dart';

Future<Connection> connect(
    String username,
    String database,
    String password,
    {String host : 'localhost', int port: 5432, bool requireSsl: false}) {
  
  var settings = new _Settings(username, database, password, host: host, port: port);

  if (requireSsl)
    return _Connection._connectSsl2(settings);
  else
    return _Connection._connect(settings);
}

abstract class ExecuteResult {
  int get lastInsertId;
  int get rowsAffected;
}

abstract class Connection {
  Stream<dynamic> query(String sql);
  Future<ExecuteResult> execute(String sql);
  void close();
}
