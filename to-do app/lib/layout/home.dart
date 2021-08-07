import 'package:flutter/material.dart';
import 'package:flutter_application_2/shared/components/components.dart';
import 'package:flutter_application_2/shared/cubit/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';

class Home extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formkey = GlobalKey<FormState>();
  bool isBottomShown = false;

  var titlecontroller = TextEditingController();
  var datecontroller = TextEditingController();
  var timecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => CubitClass()..createDatabase(),
        child: BlocConsumer<CubitClass, CubitState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              key: scaffoldKey,
              appBar: AppBar(
                title: Text(CubitClass.get(context)
                    .titles[CubitClass.get(context).crIndex]),
              ),
              body: CubitClass.get(context)
                  .screens[CubitClass.get(context).crIndex],
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  if (isBottomShown) {
                    if (formkey.currentState.validate()) {
                      CubitClass.get(context)
                          .insertRecord(
                              title: titlecontroller.text,
                              date: datecontroller.text,
                              time: timecontroller.text)
                          .then((value) {
                        Navigator.pop(context);
                      });
                    }
                  } else {
                    scaffoldKey.currentState
                        .showBottomSheet((context) => Form(
                              key: formkey,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    defaultFormField(
                                        controller: titlecontroller,
                                        label: 'Title',
                                        icon: Icons.title,
                                        validate: (String value) {
                                          if (value.isEmpty) {
                                            return 'Title must not be empty';
                                          }
                                          return null;
                                        }),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    defaultFormField(
                                        controller: timecontroller,
                                        label: 'Time',
                                        icon: Icons.watch_later_outlined,
                                        validate: (String value) {
                                          if (value.isEmpty) {
                                            return 'Time must not be empty';
                                          }
                                          return null;
                                        },
                                        ontap: () {
                                          showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now(),
                                          ).then((value) {
                                            timecontroller.text = value
                                                .format(context)
                                                .toString();
                                          });
                                        }),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    defaultFormField(
                                        controller: datecontroller,
                                        label: 'Time',
                                        icon: Icons.calendar_today,
                                        validate: (String value) {
                                          if (value.isEmpty) {
                                            return 'Date must not be empty';
                                          }
                                          return null;
                                        },
                                        ontap: () {
                                          showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime.now(),
                                                  lastDate: DateTime.parse(
                                                      '2021-09-11'))
                                              .then((value) {
                                            datecontroller.text =
                                                DateFormat.yMMMd()
                                                    .format(value);
                                          });
                                        }),
                                  ],
                                ),
                              ),
                            ))
                        .closed
                        .then((value) {
                      isBottomShown = false;
                      print('closed');
                      CubitClass.get(context).setIconFab(Icons.edit);
                    });
                    isBottomShown = true;

                    CubitClass.get(context).setIconFab(Icons.add);
                  }
                },
                child: Icon(CubitClass.get(context).fabicon),
              ),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: CubitClass.get(context).crIndex,
                elevation: 40.0,
                onTap: (index) {
                  CubitClass.get(context).bottomNavChangeState(index);
                },
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.menu), label: 'Tasks'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.check_box), label: 'Done'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.archive), label: 'Archived'),
                ],
              ),
            );
          },
        ));
  }
}
