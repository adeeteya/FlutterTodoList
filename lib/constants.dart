import 'package:firebase_auth/firebase_auth.dart';

final ActionCodeSettings kActionCodeSettings = ActionCodeSettings(
  androidPackageName: "com.adeeteya.todo_list",
  androidMinimumVersion: "1.2.0",
  dynamicLinkDomain: "adeeteya.page.link",
  androidInstallApp: true,
  handleCodeInApp: true,
  iOSBundleId: "com.adeeteya.todo_list",
  url: "https://adeeteya.page.link/todo-list/finishSignIn",
);
