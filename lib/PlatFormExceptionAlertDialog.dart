import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:time_tracker_app_original/widgets/platFormAlertDialog.dart';

class PlatExceptionFormAlertDialog extends PlatFormAlertDialog {
  PlatExceptionFormAlertDialog(
      {@required String title, @required PlatformException exception})
      : super(
            title: title, content: exception.message, defaultActionText: 'Ok');
}
