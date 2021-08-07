import 'package:flutter/material.dart';
import 'package:flutter_application_2/shared/components/components.dart';
import 'package:flutter_application_2/shared/cubit/cubit.dart';
import 'package:flutter_application_2/shared/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder/conditional_builder.dart';

class ArchivedTasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitClass, CubitState>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
            condition: CubitClass.get(context).archivedTasks.length > 0,
            fallback: (context) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.menu,
                    size: 100,
                    color: Colors.grey,
                  ),
                  Text(
                    'No Tasks Yet, Please Add More',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                ],
              ),
            ),
            builder: (context) => ListView.separated(
              itemBuilder: (context, index) => taskItem(
                CubitClass.get(context).archivedTasks[index],
                context,
              ),
              separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsetsDirectional.only(start: 20),
                child: Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey[300],
                ),
              ),
              itemCount: CubitClass.get(context).archivedTasks.length,
            ),
          );
        });
  }
}
