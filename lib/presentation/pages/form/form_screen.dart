import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taller_pragma_fase_uno/domain/entities/contact.dart';
import 'package:taller_pragma_fase_uno/presentation/providers/contacts_provider.dart';
import 'package:taller_pragma_fase_uno/presentation/widgets/text_widget.dart';
import 'package:taller_pragma_fase_uno/utils/size_constants.dart';
import 'package:taller_pragma_fase_uno/utils/string_constants.dart';

class FormScreen extends ConsumerStatefulWidget {
  const FormScreen({super.key});

  @override
  ConsumerState<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends ConsumerState<FormScreen> {
  final _phoneController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneSize = 10;
  final _avatarSizeOptions = 9;
  String _avatarSelected = '';

  @override
  void dispose() {
    _phoneController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _saveContact() async {
    final phone = _phoneController.text.trim();
    final name = _nameController.text.trim();

    if (phone.isEmpty || name.isEmpty) {
      _showDialog(StringConstants.errorTitle,
          StringConstants.emptyInformationFormScreen);
      return;
    }

    if (phone.length < _phoneSize) {
      _showDialog(StringConstants.errorTitle, StringConstants.phoneInvalid);
      return;
    }

    final contact =
        Contact(userName: name, userPhone: phone, avatarUrl: _avatarSelected);
    final success = await ref.read(contactsProvider.notifier).add(contact);

    if (!mounted) return;

    if (success) {
      _showDialog(
          StringConstants.successTitle, StringConstants.successRegister);
      _phoneController.clear();
      _nameController.clear();
      _avatarSelected = '';
      FocusScope.of(context).requestFocus(FocusNode());
    } else {
      _showDialog(StringConstants.errorTitle, StringConstants.phoneRegister);
    }
  }

  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(StringConstants.closeTitle),
          )
        ],
      ),
    );
  }

  Future<void> showAvatarPickerDialog({
    required BuildContext context,
    required List<String> avatarUrls,
    required ValueChanged<String> onAvatarSelected,
  }) async {
    await showDialog(
      context: context,
      builder: (ctx) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(SizeConstants.spacingSize16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(SizeConstants.spacingSize16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  StringConstants.selectAvatar,
                  style: TextStyle(
                      fontSize: SizeConstants.spacingSize18,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: SizeConstants.spacingSize16),
                SizedBox(
                  height: SizeConstants.spacingSize300,
                  width: SizeConstants.spacingSize300,
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: SizeConstants.crossAxisCount3,
                      crossAxisSpacing: SizeConstants.spacingSize8,
                      mainAxisSpacing: SizeConstants.spacingSize8,
                    ),
                    itemCount: avatarUrls.length,
                    itemBuilder: (context, index) {
                      final url = avatarUrls[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                          onAvatarSelected(url);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                              SizeConstants.spacingSize50),
                          child: SvgPicture.network(
                            url,
                            fit: BoxFit.cover,
                            placeholderBuilder: (ctx) => const Center(
                              child: CircularProgressIndicator(
                                  strokeWidth: SizeConstants.strokeWidth2),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextWidget(
          text: StringConstants.constFormTitle,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(SizeConstants.spacingSize16),
        child: Column(
          children: [
            InkWell(
              onTap: () async {
                final urls = List.generate(
                  _avatarSizeOptions,
                  (i) => '${StringConstants.urlIcons}$i',
                );
                await showAvatarPickerDialog(
                  context: context,
                  avatarUrls: urls,
                  onAvatarSelected: (selectedUrl) {
                    setState(() {
                      _avatarSelected = selectedUrl;
                    });
                  },
                );
              },
              child: CircleAvatar(
                radius: SizeConstants.iconSizeForm,
                backgroundColor: Colors.grey,
                child: _avatarSelected.isEmpty
                    ? const Icon(
                        Icons.camera_alt,
                        size: SizeConstants.iconSizeForm,
                      )
                    : ClipOval(
                        child: SvgPicture.network(
                          _avatarSelected,
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
            ),
            const SizedBox(height: SizeConstants.spacingSize16),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: StringConstants.userNameHint,
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(SizeConstants.spacingSize12),
                ),
              ),
            ),
            const SizedBox(height: SizeConstants.spacingSize16),
            TextField(
              maxLength: _phoneSize,
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: StringConstants.userPhoneHint,
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(SizeConstants.spacingSize12),
                ),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: SizeConstants.spacingSize16),
            ElevatedButton.icon(
              onPressed: _saveContact,
              icon: const Icon(Icons.save_outlined),
              label: const TextWidget(
                text: StringConstants.addContact,
                fontSize: SizeConstants.fontSizeCardDescription,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
