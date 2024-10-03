import 'package:flutter/material.dart';

class RsaScreen extends StatefulWidget {
  const RsaScreen({super.key});

  @override
  State<RsaScreen> createState() => _RsaScreenState();
}

class _RsaScreenState extends State<RsaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            pinned: true,
            title: const Text('Criptografia assimétrica'),
            actions: [
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    showDragHandle: true,
                    useRootNavigator: true,
                    isScrollControlled: true,
                    useSafeArea: true,
                    builder: (context) {
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.viewInsetsOf(context).bottom,
                        ),
                        child: const Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Chave pública',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 24),
                            Text(
                              'aidnffpcmfejjckekmfkfffc-fs=a=2##jrnfo/jalaodpaq-|opcvvsmlartew=(',
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Chave privada',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 24),
                            Text(
                              'aidnffpcmfejjckekmfkfffc-fs=a=2##jrnfo/jalaodpaq-|opcvvsmlartew=(',
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    },
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
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              showDragHandle: true,
                              useRootNavigator: true,
                              isScrollControlled: true,
                              useSafeArea: true,
                              builder: (context) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                    bottom:
                                        MediaQuery.viewInsetsOf(context).bottom,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        maxLines: 10,
                                        maxLength: 250,
                                        onTapOutside: (_) =>
                                            FocusScope.of(context).unfocus(),
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor:
                                              Colors.grey.withOpacity(.1),
                                          hintText:
                                              'Texto a ser criptografado...',
                                          hintStyle: TextStyle(
                                            color: Colors.grey[600],
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide.none,
                                          ),
                                        ),
                                        onChanged: (_) => setState(() {}),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: const SizedBox(
                            width: double.infinity,
                            child: Card(
                              child: Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Text(
                                  textToEncrypt,
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
                        const SizedBox(
                          width: double.infinity,
                          child: Card(
                            child: Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Text(
                                '',
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text('Gerar par de chaves'),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text('Encriptar texto'),
                        ),
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

const textToEncrypt =
    'Eu sou o Eliude Vemba, e eu desenvolvi esta aplicação do zero';
