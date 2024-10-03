import 'package:cypher/presentation/widgets/edit_text_to_encrypt.dart';
import 'package:cypher/presentation/widgets/show_keys.dart';
import 'package:cypher/presentation/encryption/rsa/provider/rsa_screen_notifier.dart';
import 'package:cypher/utils/show_modal_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RsaScreen extends ConsumerWidget {
  const RsaScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(rsaScreenNotifierProvider);
    final notifier = ref.watch(rsaScreenNotifierProvider.notifier);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            pinned: true,
            title: const Text('Criptografia assimétrica'),
            actions: [
              IconButton(
                onPressed: () async {
                  await showCustomModalBottomSheet(
                    context: context,
                    child: ShowKeys(
                      title1: 'Chave pública',
                      key1: state.publicKey,
                      title2: 'Chave privada',
                      key2: state.privateKey,
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
                              'Criptografia assimétrica',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'é qualquer sistema criptográfico que usa pares de chaves: chaves públicas, que podem ser amplamente disseminadas, e chaves privadas que são conhecidas apenas pelo proprietário. Isto realiza duas funções: autenticação, onde a chave pública verifica que um portador da chave privada parelhada enviou a mensagem, e encriptação, onde apenas o portador da chave privada parelhada pode decriptar a mensagem encriptada com a chave pública.',
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
                                      .read(rsaScreenNotifierProvider.notifier)
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
                                padding: const EdgeInsets.all(20.0),
                                child: Text(
                                  state.textToEncrypt,
                                  textAlign: TextAlign.center,
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
                            ref
                                .read(rsaScreenNotifierProvider.notifier)
                                .generateKeys();

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
                          child: const Text('Gerar par de chaves'),
                        ),
                        if (notifier.canEncrypt) ...[
                          ElevatedButton(
                            onPressed: () {
                              ref
                                  .read(rsaScreenNotifierProvider.notifier)
                                  .encryptText();
                            },
                            child: const Text('Encriptar texto'),
                          ),
                        ],
                        if (notifier.canDecrypt) ...[
                          ElevatedButton(
                            onPressed: () {
                              final result = ref
                                  .read(rsaScreenNotifierProvider.notifier)
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
