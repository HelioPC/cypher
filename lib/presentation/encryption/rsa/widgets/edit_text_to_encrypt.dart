import 'package:cypher/presentation/encryption/rsa/provider/rsa_screen_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditTextToEncrypt extends ConsumerWidget {
  const EditTextToEncrypt({super.key, required this.textToEncrypt});

  final String textToEncrypt;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            maxLines: 10,
            maxLength: 250,
            onTapOutside: (_) => FocusScope.of(context).unfocus(),
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.withOpacity(.1),
              hintText: textToEncrypt,
              hintStyle: TextStyle(
                color: Colors.grey[600],
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
            onSubmitted: (value) {
              ref
                  .read(rsaScreenNotifierProvider.notifier)
                  .setTextToEncrypt(value);

              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
