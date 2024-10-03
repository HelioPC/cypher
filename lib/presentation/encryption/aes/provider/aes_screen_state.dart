import 'package:freezed_annotation/freezed_annotation.dart';

part 'aes_screen_state.freezed.dart';

@freezed
class AesScreenState with _$AesScreenState {
  factory AesScreenState({
    required String aesKey,
    required String iv,
    required String encryptedText,
    required String textToEncrypt,
  }) = _AesScreenState;
}
