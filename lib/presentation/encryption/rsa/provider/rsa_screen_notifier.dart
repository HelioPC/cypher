import 'package:cypher/presentation/encryption/rsa/provider/rsa_screen_state.dart';
import 'package:cypher/services/crypto_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'rsa_screen_notifier.g.dart';

@riverpod
class RsaScreenNotifier extends _$RsaScreenNotifier {
  @override
  RsaScreenState build() {
    return const RsaScreenState(
      publicKey: '',
      privateKey: '',
      encryptedText: '',
      textToEncrypt:
          'Eu sou o Eliude Vemba, e eu desenvolvi esta aplicação do zero',
    );
  }

  bool get canEncrypt {
    return state.publicKey.isNotEmpty &&
        state.textToEncrypt.isNotEmpty &&
        state.encryptedText.isEmpty;
  }

  bool get canDecrypt {
    return state.privateKey.isNotEmpty &&
        state.textToEncrypt.isNotEmpty &&
        state.encryptedText.isNotEmpty;
  }

  void generateKeys() {
    final keys = CryptoService.generateRSAKeys();

    state = state.copyWith(
      publicKey: keys['publicKey']!,
      privateKey: keys['privateKey']!,
      encryptedText: '',
    );
  }

  void setTextToEncrypt(String textToEncrypt) {
    state = state.copyWith(
      textToEncrypt: textToEncrypt,
      encryptedText: '',
    );
  }

  void encryptText() {
    final encrypted = CryptoService.encryptWithPublicRSA(
      plaintext: state.textToEncrypt,
      publicKeyRSA: state.publicKey,
    );

    state = state.copyWith(encryptedText: encrypted);
  }

  String decryptText() {
    final decrypted = CryptoService.decryptWithPrivateRSA(
      encryptedText: state.encryptedText,
      privateKeyRSA: state.privateKey,
    );

    return decrypted;
  }
}
