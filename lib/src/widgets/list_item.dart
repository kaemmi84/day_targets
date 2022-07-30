import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ListItem extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  final void Function()? onEditingComplete;
  final void Function(BuildContext context)? onDeleteClick;
  final void Function()? onDeleteSlide;
  final void Function(String value)? onChange;
  final void Function(FocusNode focusNode)? onFocusChange;

  const ListItem({
    Key? key,
    required this.controller,
    this.hintText,
    this.onEditingComplete,
    this.onChange,
    this.onDeleteClick,
    this.onDeleteSlide,
    this.onFocusChange
  }) : super(key: key);

  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  bool _isEnabled = false;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var listTile = ListTile(
      title: TextField(
        controller: widget.controller,
        focusNode: _focusNode,
        enabled: _isEnabled,
        decoration: InputDecoration(
          hintText: widget.hintText,
        ),
        onChanged: (value) {
          if(widget.onChange != null) {
            widget.onChange!.call(value);
          }
        },
        onSubmitted: (value) {
          print('submitting');
        },
        onEditingComplete: () {
          setState(() {
            _isEnabled = !_isEnabled;
          });
          if (widget.onEditingComplete != null) {
            widget.onEditingComplete!.call();
          }
        },
      ),
      enableFeedback: true,
      onTap: () {
        setState(() {
          Future.delayed(const Duration(milliseconds: 10), () {
            _focusNode.requestFocus();
          });
          _isEnabled = !_isEnabled;
        });
      },
    );
    if (widget.onDeleteSlide != null || widget.onDeleteClick != null) {
      return Slidable(
        key: UniqueKey(),
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          dismissible: DismissiblePane(onDismissed: () {
            if (widget.onDeleteSlide != null) {
              widget.onDeleteSlide!.call();
            }
          }),
          children: [
            SlidableAction(
              onPressed: (context) {
                if (widget.onDeleteClick != null) {
                  widget.onDeleteClick!.call(context);
                }
              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Löschen',
            )
          ],
        ),
        child: listTile,
      );
    } else {
      return listTile;
    }
  }

  void _onFocusChange() {
    if(widget.onFocusChange != null) {
      widget.onFocusChange!.call(_focusNode);
    }
  }
}
