import 'package:crypto/crypto.dart';
import 'dart:convert';

String calculateHash(String value) {
  final bytes = utf8.encode(value);
  final hash = sha256.convert(bytes);

  print("pass a has: " + value);
 
    print("hash: " + hash.toString());
  return hash.toString();
}
