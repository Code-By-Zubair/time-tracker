import 'dart:convert';

class EncryptionDecryptionHelper {
static  const secretKey = "support@virtuenetz.com-time-tracker";
  static String encrypt(String plainText) {
    final keyBytes = utf8.encode(secretKey);
    final plainBytes = utf8.encode(plainText);
    final keyLength = keyBytes.length;

    for (int i = 0; i < plainBytes.length; i++) {
      plainBytes[i] ^= keyBytes[i % keyLength];
    }

    return base64.encode(plainBytes);
  }

 static  String decrypt(String encryptedText) {
    final keyBytes = utf8.encode(secretKey);
    final encryptedBytes = base64.decode(encryptedText);
    final keyLength = keyBytes.length;

    for (int i = 0; i < encryptedBytes.length; i++) {
      encryptedBytes[i] ^= keyBytes[i % keyLength];
    }

    return utf8.decode(encryptedBytes);
  }
}
