import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/presentation_layer/modules/user/login/login_screen.dart';
import 'package:shop_app/presentation_layer/shared/sharedPrefrences/sharedprefrences.dart';
import 'package:shop_app/presentation_layer/shared/style/style/style/style.dart';

Widget defaultTextFormField({
  TextEditingController? controller,
  TextInputType? keyboardType,
  String? labelText,
  double radius = 10,
  TextStyle? labelStyle,
  Widget? suffixIcon,
  Widget? prefixIcon,
  ValueChanged<String>? onChanged,
  FormFieldValidator<String>? validator,
  ValueChanged<String>? onSubmite,
  bool obscureText = false,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: keyboardType,
    decoration: InputDecoration(
      labelText: labelText,
      labelStyle: labelStyle ?? fontAppStyle,
      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
    ),
    obscureText: obscureText,
    onChanged: onChanged,
    validator: validator,
    onFieldSubmitted: onSubmite,
  );
}

Widget defaultTextButton({
  required VoidCallback onPressed,
  required Widget child,
}) {
  return TextButton(
    onPressed: onPressed,
    child: child,
  );
}

Widget defaultButton({
  required VoidCallback onPressed,
  String? text,
  bool isUpperCase = false,
  double height = 50,
  double width = double.infinity,
  MaterialColor? color,
  double radius = 10,
}) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      color: color ?? defaultAppColor,
    ),
    child: MaterialButton(
      onPressed: onPressed,
      child: Text(
        isUpperCase ? text.toString().toUpperCase() : '$text',
        style: fontAppStyle.copyWith(color: Colors.white),
      ),
    ),
  );
}

void navigatePushTo({
  required BuildContext context,
  required Widget navigateTo,
}) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => navigateTo));
}

void navigatePushANDRemoveRout({
  required BuildContext context,
  required Widget navigateTo,
}) {
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => navigateTo,
      ),
      (route) => false);
}

void showToast({
  required String message,
  required ToastState state,
}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

enum ToastState { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastState state) {
  Color color;

  switch (state) {
    case ToastState.SUCCESS:
      color = Colors.green;
      break;
    case ToastState.ERROR:
      color = Colors.red;
      break;
    case ToastState.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

void logout(BuildContext context) {
  CachHelper.removeData(key: 'token').then(
    (value) {
      if (value) {
        navigatePushANDRemoveRout(context: context, navigateTo: Login_screen());
      }
    },
  );
}
