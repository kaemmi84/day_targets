import 'package:flutter/material.dart';

class AppEditableListTile extends StatefulWidget {
  final void Function(String value) onSubmit;
  final bool editMode;
  final String value;
  final String labelText;

  const AppEditableListTile({
    required this.onSubmit,
    required this.editMode,
    required this.value,
    required this.labelText,
    Key? key
  }) : super(key: key);
  @override
  State<AppEditableListTile> createState() => _AppEditableListTile();
}

class _AppEditableListTile extends State<AppEditableListTile>  {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          ListTile(
            title: widget.editMode
                ? TextField(
                obscureText: false,
                autofocus: false,
                onSubmitted: widget.onSubmit,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: widget.labelText
                )
            )
                : Text(widget.value),
            trailing: widget.editMode
                ? null : IconButton(
              icon: const Icon(Icons.check_sharp),
              onPressed: () {},
            ),
          ),
          const Divider(),
        ]);
  }
}