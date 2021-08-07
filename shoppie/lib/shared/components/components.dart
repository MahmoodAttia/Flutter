import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shoppie/shared/components/constants.dart';

Widget defaultInput({
  required TextEditingController controller,
  required Function onSubmit,
  required Function validator,
  required String? label,
  required TextInputType type,
  String? hint,
  bool obsecure = false,
  Function? sufFun,
  IconData? prefixIcon,
  Widget? suffixIcon,
}) {
  return TextFormField(
    controller: controller,
    onFieldSubmitted: (String s) {
      return onSubmit(s);
    },
    decoration: InputDecoration(
        hintText: hint,
        helperStyle: TextStyle(color: Colors.grey),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(
            color: Colors.grey.shade100,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(
            color: Colors.grey.shade100,
            width: 2.0,
          ),
        ),
        contentPadding: EdgeInsets.all(0),
        labelText: label,
        prefixIcon: Icon(prefixIcon),
        suffixIcon: suffixIcon),
    keyboardType: type,
    obscureText: obsecure,
    validator: (s) => validator(s),
  );
}

Widget defaultButton(
    {required Function onPressed,
    required String text,
    required context,
    Color? color = defaultColor,
    double width = 300,
    double radius = 30,
    double height = 50}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(radius),
        ),
        color: color),
    child: TextButton(
      onPressed: () {
        return onPressed();
      },
      child: Text(text,
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(fontSize: 15, color: Colors.white)),
    ),
  );
}

Future<bool?> showToast({
  required String msg,
  required Color color,
}) async {
  return await Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0);
}
