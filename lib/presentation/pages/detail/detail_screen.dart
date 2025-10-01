import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taller_pragma_fase_uno/domain/entities/contact.dart';
import 'package:taller_pragma_fase_uno/presentation/widgets/text_widget.dart';
import 'package:taller_pragma_fase_uno/utils/size_constants.dart';
import 'package:taller_pragma_fase_uno/utils/string_constants.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({
    super.key,
    required this.contact,
  });

  final Contact contact;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextWidget(text: StringConstants.constDetailTitle),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            CircleAvatar(
              radius: SizeConstants.iconSizeForm,
              backgroundColor: Colors.grey,
              child: contact.avatarUrl.isEmpty
                  ? const Icon(
                      Icons.person,
                      size: SizeConstants.iconSizeForm,
                    )
                  : ClipOval(
                      child: SvgPicture.network(
                        contact.avatarUrl,
                        fit: BoxFit.cover,
                        width: SizeConstants.iconSizeForm * 2,
                        height: SizeConstants.iconSizeForm * 2,
                        placeholderBuilder: (ctx) => const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: SizeConstants.strokeWidth2,
                          ),
                        ),
                      ),
                    ),
            ),
            const SizedBox(
              height: SizeConstants.spacingSize16,
            ),
            TextWidget(
              text: contact.userName,
              fontSize: SizeConstants.fontSizeCardTitle,
            ),
            const SizedBox(
              height: SizeConstants.spacingSize4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: contact.userPhone));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text(StringConstants.numberCopy)),
                    );
                  },
                  child: Row(
                    children: [
                      TextWidget(
                        text: contact.userPhone,
                        fontSize: SizeConstants.fontSizeCardDescription,
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.copy, size: 20),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
