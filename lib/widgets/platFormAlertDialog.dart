import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker_app_original/widgets/PlatFormWidgets.dart';

class PlatFormAlertDialog extends PlatFormWidgets {
  PlatFormAlertDialog(
      {@required this.title,
      @required this.content,
      @required this.defaultActionText,
      this.cancelActionText})
      : assert(title != null),
        assert(content != null),
        assert(defaultActionText != null);

  final String title;
  final String content;
  final String defaultActionText;
  final String cancelActionText;

  Future<bool> show(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder: (context) => this,
      barrierDismissible: false,
    );
  }

  @override
  Widget buildCupertinoWidgets(BuildContext context) {
    return CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: _buildActions(context));
  }

  @override
  Widget buildMaterialWidgets(BuildContext context) {
    return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: _buildActions(context));
  }

  //this method builds the actions that would be passed inside the actions object
  List<Widget> _buildActions(BuildContext context) {
    final actions = <Widget>[];
    if (cancelActionText != null) {
      actions.add(
        PlatFormAlertDialogActions(
          child: Text(cancelActionText),
          onPressed: () => Navigator.of(context).pop(false),
        ),
      );
    }
    actions.add(
      PlatFormAlertDialogActions(
        child: Text(defaultActionText),
        onPressed: () => Navigator.of(context).pop(true),
      ),
    );
    return actions;
  }
}

class PlatFormAlertDialogActions extends PlatFormWidgets {
  PlatFormAlertDialogActions({this.child, this.onPressed});

  final Widget child;
  final VoidCallback onPressed;

  @override
  Widget buildCupertinoWidgets(BuildContext context) {
    return CupertinoDialogAction(
      child: child,
      onPressed: onPressed,
    );
  }

  @override
  Widget buildMaterialWidgets(BuildContext context) {
    return FlatButton(
      child: child,
      onPressed: onPressed,
    );
  }
}
