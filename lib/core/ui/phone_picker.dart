import 'package:bill_share/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PhonePicker extends StatelessWidget {
  final PhoneCode? value;
  final Function({PhoneCode? value}) onTap;

  const PhonePicker({
    super.key,
    this.value = PhoneCode.vn,
    required this.onTap,
  });

  void _dialogBuilder(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: true,
      useSafeArea: true,
      barrierColor: Theme.of(context).scaffoldBackgroundColor,
      builder: (BuildContext context) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () => context.pop(),
                        child: Text("Cancel"),
                      ),
                    ),
                    Text(
                      "Choose a country",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.separated(
                    itemCount: PhoneCode.values.length,
                    itemBuilder: (context, index) {
                      final item = PhoneCode.values[index];
                      return ListTile(
                        leading: Image.asset(item.flagImage, scale: 50),
                        title: Text(item.displayText),
                        trailing: Text(item.displayNumberZone),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        onTap: () {
                          onTap(value: item);
                          context.pop();
                        },
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
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
    return SizedBox(
      height: 56,
      child: OutlinedButton.icon(
        onPressed: () => _dialogBuilder(context),
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          padding: EdgeInsets.all(10),
        ),
        icon: value?.flagImage != null
            ? Image.asset(value!.flagImage, scale: 50)
            : null,
        label: Row(
          children: [
            Text(
              value?.displayNumberZone ?? "",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
}
