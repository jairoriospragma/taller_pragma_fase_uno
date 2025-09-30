import 'package:flutter/material.dart';
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
            const CircleAvatar(
              radius: SizeConstants.iconRadius,
              backgroundColor: Colors.grey,
              child: Icon(
                Icons.person,
                size: SizeConstants.iconSize,
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
            TextWidget(
              text: contact.userPhone,
              fontSize: SizeConstants.fontSizeCardDescription,
            ),
          ],
        ),
      ),
    );
  }
}
