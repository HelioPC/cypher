import 'package:freezed_annotation/freezed_annotation.dart';
part 'rsa_screen_state.freezed.dart';

@freezed
class RsaScreenState with _$RsaScreenState {
  const factory RsaScreenState({
    required String publicKey,
    required String privateKey,
    required String encryptedText,
    required String textToEncrypt,
  }) = _RsaScreenState;
}
