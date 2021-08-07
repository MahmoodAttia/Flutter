import 'package:flutter/material.dart';
import 'package:flutter_application_2/shared/cubit/cubit.dart';
import 'package:conditional_builder/conditional_builder.dart';

Widget defaultFormField({
  @required TextEditingController controller,
  Function ontap,
  Function validate,
  @required String label,
  @required IconData icon,
  TextInputType keytype = TextInputType.text,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: keytype,
    onTap: ontap,
    validator: validate,
    decoration: InputDecoration(
        labelText: label,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0x55555555))),
        prefixIcon: Icon(icon),
        focusedBorder: OutlineInputBorder()),
  );
}

Widget taskItem(Map model, context) {
  return Dismissible(
    onDismissed: (d) {
      CubitClass.get(context).deleteRecord(model['id']);
    },
    key: Key(model['id'].toString()),
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            child: Text(
              '${model['time']}',
            ),
          ),
          SizedBox(
            width: 25.0,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model['title']}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '${model['date']}',
                  style: TextStyle(color: Colors.grey[450]),
                ),
              ],
            ),
          ),
          IconButton(
              icon: Icon(Icons.check_box),
              onPressed: () {
                CubitClass.get(context).updateRecord('done', model['id']);
              }),
          IconButton(
              icon: Icon(Icons.archive_rounded),
              onPressed: () {
                CubitClass.get(context).updateRecord('archived', model['id']);
              }),
        ],
      ),
    ),
  );
}
