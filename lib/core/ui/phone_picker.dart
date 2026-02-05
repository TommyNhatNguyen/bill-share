import 'package:bill_share/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PhonePicker extends StatelessWidget {
  final PhoneNumberZone? value;
  final Function({PhoneNumberZone? value}) onTap;

  const PhonePicker({super.key, this.value, required this.onTap});

  void _dialogBuilder(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: true,
      builder: (BuildContext context) {
        return SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: FilledButton(
            onPressed: () {
              onTap(value: PhoneNumberZone.us);
              context.pop();
            },
            child: Text("htestset"),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => _dialogBuilder(context),
      child: value != null ? Text(value!.value) : Text("Hello"),
    );
  }
}
