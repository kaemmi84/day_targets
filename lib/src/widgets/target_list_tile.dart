import 'package:day_targets/src/models/target.dart';
import 'package:flutter/material.dart';

enum Mode {
  edit,
  create,
  show
}

class TargetListTile extends StatefulWidget {
  final void Function(String value) onSubmit;
  final void Function(Mode mode, Target target) onEditModeChange;
  final Mode editMode;
  final String value;
  final String labelText;
  final Target target;

  const TargetListTile({
    required this.onSubmit,
    required this.editMode,
    required this.value,
    required this.labelText,
    required this.target,
    required this.onEditModeChange,
    Key? key,
  }) : super(key: key);
  @override
  State<TargetListTile> createState() => _TargetListTile();
}

class _TargetListTile extends State<TargetListTile>  {
  late Mode _editMode;
  late FocusNode _focusNode;
  final _editController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          ListTile(
              title: _getListContent(),
              trailing: trailingButton,
              onLongPress: _onLongPress
          ),
          const Divider(),
        ]);
  }

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _editMode = widget.editMode;
    _editController.text = widget.value;
  }

  @override
  void dispose() {
    _editController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onSubmitted(String value) {
    setState(() {
      _editMode = Mode.show;
      widget.onSubmit.call(value);
    });
  }

  void _onLongPress() {
    if(_editMode == Mode.show) {
      setState(() {
        _editMode = Mode.edit;
        widget.onEditModeChange.call(_editMode, widget.target);
        _focusNode.requestFocus();
      });
    }
  }

  _getListContent() {
    switch (_editMode) {
      case Mode.edit:
      case Mode.create:
        return TextField(
            controller: _editController,
            obscureText: false,
            autofocus: false,
            onSubmitted: _onSubmitted,
            focusNode: _focusNode,
            onEditingComplete: () {
              setState(() {
                _editMode = Mode.show;
              });
            },
            // decoration: InputDecoration(
            //     border: const OutlineInputBorder(),
            //     labelText: widget.labelText
            // )
        );
      case Mode.show:
        return Text(widget.value);
    }
  }

  Widget? get trailingButton {
    switch (_editMode) {
      case Mode.edit:
        return IconButton(
          icon: const Icon(Icons.delete_forever_outlined),
          color: Colors.red,
          onPressed: () {},
        );
      case Mode.create:
        return null;
      case Mode.show:
        return IconButton(
          icon: const Icon(Icons.check_sharp),
          onPressed: () {},
        );
    }
  }
}