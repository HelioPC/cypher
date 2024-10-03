import 'package:basic_utils/basic_utils.dart';
import 'package:encrypt/encrypt.dart';

sealed class CryptoService {
  static String generateAESKey() {
    final key = Key.fromSecureRandom(32);

    return key.base64;
  }

  static Map<String, String> generateRSAKeys() {
    final keys = CryptoUtils.generateRSAKeyPair();

    return {
      'publicKey': keys.publicKey.toString(),
      'privatKey': keys.privateKey.toString(),
    };
  }

  static String encryptWithPublicRSA({
    required String plaintext,
    required String publicKeyRSA,
  }) {
    RSAPublicKey publicKey = CryptoUtils.rsaPublicKeyFromPem(publicKeyRSA);

    final encrypted = CryptoUtils.rsaEncrypt(plaintext, publicKey);

    return encrypted;
  }

  static String decryptWithPrivateRSA({
    required String encryptedText,
    required String privateKeyRSA,
  }) {
    RSAPrivateKey privateKey = CryptoUtils.rsaPrivateKeyFromPem(privateKeyRSA);

    final decrypted = CryptoUtils.rsaDecrypt(encryptedText, privateKey);

    return decrypted;
  }

  static Map<String, String> encryptWithAES({
    required String plaintext,
    required String aesKeyBase64,
  }) {
    final key = Key.fromBase64(aesKeyBase64);
    final iv = IV.fromSecureRandom(16);

    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final encrypted = encrypter.encrypt(plaintext, iv: iv);

    return {
      'encryptedMessage': encrypted.base64,
      'iv': iv.base64,
    };
  }

  static String decryptWithAES({
    required String encryptedText,
    required String aesKeyBase64,
    required String ivBase64,
  }) {
    final key = Key.fromBase64(aesKeyBase64);
    final ivObject = IV.fromBase64(ivBase64);

    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final decrypted = encrypter.decrypt64(encryptedText, iv: ivObject);

    return decrypted;
  }
}
