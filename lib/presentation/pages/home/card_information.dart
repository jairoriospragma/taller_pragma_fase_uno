import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taller_pragma_fase_uno/presentation/widgets/text_widget.dart';
import 'package:taller_pragma_fase_uno/utils/size_constants.dart';

class CardInformation extends StatelessWidget {
  const CardInformation({
    super.key,
    required this.avatarUrl,
    required this.userName,
    required this.userPhone,
  });

  final String avatarUrl;
  final String userName;
  final String userPhone;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: SizeConstants.spacingSize16,
        vertical: SizeConstants.spacingSize8,
      ),
      elevation: SizeConstants.cardElevation,
      child: Padding(
        padding: const EdgeInsets.all(
          SizeConstants.spacingSize16,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: SizeConstants.iconRadius,
              backgroundColor: Colors.grey,
              child: avatarUrl.isEmpty
                  ? const Icon(
                      Icons.person,
                      size: SizeConstants.iconRadius,
                    )
                  : ClipOval(
                      child: SvgPicture.network(
                        avatarUrl,
                        fit: BoxFit.cover,
                        width: SizeConstants.iconRadius * 2,
                        height: SizeConstants.iconRadius * 2,
                        placeholderBuilder: (ctx) => const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: SizeConstants.strokeWidth2,
                          ),
                        ),
                      ),
                    ),
            ),
            const SizedBox(
              width: SizeConstants.spacingSize16,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: userName,
                    fontSize: SizeConstants.fontSizeCardTitle,
                  ),
                  const SizedBox(height: SizeConstants.spacingSize4),
                  TextWidget(
                    text: userPhone,
                    fontSize: SizeConstants.fontSizeCardDescription,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
