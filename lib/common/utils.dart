
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:single_sign_in_firestore/common/custom_alert_dialog.dart';

class Utils {
  static void showRegistrationDialog(BuildContext context, Function completion) {
    SchedulerBinding.instance.addPostFrameCallback((_) =>
        CustomAlertDialog(context).showRegisterAlert(
                () {
              completion();
            }));
  }
}