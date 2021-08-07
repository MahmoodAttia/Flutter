import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppie/layout/cubit/shop_cubit.dart';
import 'package:shoppie/layout/cubit/shop_state.dart';
import 'package:shoppie/models/faqs_model.dart';

class FaqsScreen extends StatelessWidget {
  const FaqsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Center(
                  child: Text(
                    'FAQS',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(
                      height: 30,
                    ),
                    itemBuilder: (context, index) => faqItem(
                        ShopCubit.get(context).faqModel!.data!.data![index]),
                    itemCount:
                        ShopCubit.get(context).faqModel!.data!.data!.length,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget faqItem(FaqData faqData) {
    return Container(
      padding: EdgeInsets.all(8),
      color: Colors.grey[100],
      child: ExpandablePanel(
        header: Text(
          faqData.question!,
          style: TextStyle(
              fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        collapsed: Text(
          faqData.answer!,
          style: TextStyle(
            fontSize: 17,
            color: Colors.grey[500],
          ),
          softWrap: true,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        expanded: Text(
          faqData.answer!,
          style: TextStyle(
            fontSize: 17,
            color: Colors.grey[600],
          ),
          softWrap: true,
        ),
      ),
    );
  }
}
