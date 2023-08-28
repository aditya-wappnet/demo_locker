import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:pointycastle/export.dart';

String encryptData(String data, Uint8List encryptionKey) {
  final encrypter = BlockCipher('AES')..init(true, KeyParameter(encryptionKey));
  final paddedData = data.padRight(16); // Ensure data is multiple of 16 bytes
  final encryptedData =
      encrypter.process(Uint8List.fromList(paddedData.codeUnits));
  return base64.encode(encryptedData);
}

String decryptData(String encryptedData, Uint8List decryptionKey) {
  final encrypter = BlockCipher('AES')
    ..init(false, KeyParameter(decryptionKey));
  final decryptedData =
      String.fromCharCodes(encrypter.process(base64.decode(encryptedData)));
  return decryptedData.trim();
}
