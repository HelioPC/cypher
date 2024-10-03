import 'package:cypher/presentation/encryption/aes/provider/aes_screen_notifier.dart';
import 'package:cypher/presentation/widgets/edit_text_to_encrypt.dart';
import 'package:cypher/presentation/widgets/show_keys.dart';
import 'package:cypher/services/crypto_service.dart';
import 'package:cypher/utils/show_modal_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AesScreen extends ConsumerWidget {
  const AesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(aesScreenNotifierProvider);
    final notifier = ref.watch(aesScreenNotifierProvider.notifier);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            pinned: true,
            title: const Text('Criptografia simétrica'),
            actions: [
              IconButton(
                onPressed: () async {
                  await showCustomModalBottomSheet(
                    context: context,
                    child: ShowKeys(
                      title1: 'Chave AES',
                      key1: state.aesKey,
                      title2: 'IV',
                      key2: state.iv,
                    ),
                  );
                },
                icon: const Icon(Icons.visibility),
              ),
            ],
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 28)),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Algoritmos de criptografia simétrica',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'são algoritmos para criptografia que usam a mesma chave criptográfica para encriptação de texto puro e decriptação de texto cifrado',
                            ),
                          ],
                        ),
                        const SizedBox(height: 28),
                        GestureDetector(
                          onTap: () async {
                            await showCustomModalBottomSheet(
                              context: context,
                              child: EditTextToEncrypt(
                                textToEncrypt: state.textToEncrypt,
                                onSubmitted: (value) {
                                  ref
                                      .read(aesScreenNotifierProvider.notifier)
                                      .setTextToEncrypt(value);

                                  Navigator.of(context).pop();
                                },
                              ),
                            );
                          },
                          child: SizedBox(
                            width: double.infinity,
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  state.textToEncrypt,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontFamily: 'GreatVibes',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            'Texto a ser criptografado',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                state.encryptedText,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        const Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            'Texto criptografado',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const ExpansionTile(
                          leading: Icon(Icons.visibility),
                          title: Text('Nota importante'),
                          children: [
                            Text(
                              'Para garantir com que a criptografia simétrica gere um payload (texto criptografado) diferente, usando a mesma chave (AES) e o mesmo texto, usamos um IV (vetor de inicialização) sempre que o utilizador encripta o texto.',
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SafeArea(
                    child: Row(
                      mainAxisAlignment:
                          (notifier.canEncrypt || notifier.canDecrypt)
                              ? MainAxisAlignment.spaceBetween
                              : MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            final aesKey = CryptoService.generateAESKey();

                            ref
                                .read(aesScreenNotifierProvider.notifier)
                                .setAesKey(aesKey);

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                duration: Duration(seconds: 2),
                                content: Text(
                                  'Chave gerada com sucesso.',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          },
                          child: const Text('Gerar chave AES'),
                        ),
                        if (notifier.canEncrypt) ...[
                          ElevatedButton(
                            onPressed: () {
                              ref
                                  .read(aesScreenNotifierProvider.notifier)
                                  .encryptText();
                            },
                            child: const Text('Encriptar texto'),
                          ),
                        ],
                        if (notifier.canDecrypt) ...[
                          ElevatedButton(
                            onPressed: () {
                              final result = ref
                                  .read(aesScreenNotifierProvider.notifier)
                                  .decryptText();

                              showAdaptiveDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog.adaptive(
                                    content: Column(children: [Text(result)]),
                                    actions: [
                                      CupertinoDialogAction(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Ok'),
                                      )
                                    ],
                                  );
                                },
                              );
                            },
                            child: const Text('Decriptar texto'),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
