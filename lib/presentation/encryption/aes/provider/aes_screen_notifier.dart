import 'package:cypher/presentation/encryption/aes/provider/aes_screen_state.dart';
import 'package:cypher/services/crypto_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'aes_screen_notifier.g.dart';

@riverpod
class AesScreenNotifier extends _$AesScreenNotifier {
  @override
  AesScreenState build() {
    return AesScreenState(
      aesKey: '',
      encryptedText: '',
      textToEncrypt:
          'Eu sou o Eliude Vemba, e eu desenvolvi esta aplicação do zero',
      iv: '',
    );
  }

  bool get canEncrypt {
    return state.aesKey.isNotEmpty &&
        state.textToEncrypt.isNotEmpty &&
        state.encryptedText.isEmpty;
  }

  bool get canDecrypt {
    return state.aesKey.isNotEmpty &&
        state.textToEncrypt.isNotEmpty &&
        state.iv.isNotEmpty &&
        state.encryptedText.isNotEmpty;
  }

  void setAesKey(String aesKey) {
    state = state.copyWith(aesKey: aesKey, encryptedText: '', iv: '');
  }

  void setTextToEncrypt(String textToEncrypt) {
    state = state.copyWith(
      textToEncrypt: textToEncrypt,
      encryptedText: '',
      iv: '',
    );
  }

  void encryptText() {
    final encrypted = CryptoService.encryptWithAES(
      plaintext: state.textToEncrypt,
      aesKeyBase64: state.aesKey,
    );

    state = state.copyWith(
      encryptedText: encrypted['encryptedMessage']!,
      iv: encrypted['iv']!,
    );
  }

  String decryptText() {
    final decrypted = CryptoService.decryptWithAES(
      encryptedText: state.encryptedText,
      aesKeyBase64: state.aesKey,
      ivBase64: state.iv,
    );

    return decrypted;
  }
}
