import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplitScreen extends StatefulWidget {
  const SplitScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SplitScreenState();
  }
}

class _SplitScreenState extends State<SplitScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _splitAmountController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _splitAmountController.dispose();
  }

  void onSubmit() {
    final isValidated = _formKey.currentState!.validate();
    if (isValidated) {
      print(_nameController.text);
      print(_splitAmountController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create a new split",
          style: Theme.of(
            context,
          ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w500),
        ),
        backgroundColor: Theme.of(context).primaryColorLight,
        leading: IconButton(
          onPressed: () => GoRouter.of(context).pop(),
          icon: Icon(Icons.close),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SafeArea(
          minimum: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      label: Text("Bill's name*"),
                      icon: Icon(Icons.view_list_sharp),
                      hint: Text("Lunch Break 20/10/2025..."),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Bill name can't be empty";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _splitAmountController,
                    decoration: InputDecoration(
                      label: Text("Split amount*"),
                      icon: Icon(Icons.monetization_on_rounded),
                      hint: Text("100.000"),
                    ),
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Split amount can't be empty";
                      }
                      return null;
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              DropdownMenu(
                dropdownMenuEntries: [],
                label: Text("hello"),
                width: double.infinity,
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: onSubmit,
                  label: Text('Create a new split'),
                  icon: Icon(Icons.add),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
