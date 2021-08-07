import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppie/models/category_data_model.dart';
import 'package:shoppie/modules/product/product_screen.dart';
import 'package:shoppie/shared/components/components.dart';
import 'package:shoppie/shared/components/constants.dart';

import 'cubit/search_cubit.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var searchController = TextEditingController();
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultInput(
                        controller: searchController,
                        onSubmit: (String text) {
                          SearchCubit.get(context).searchProducts(text);
                        },
                        validator: (s) {
                          if (s!.isEmpty) return 'Search must not be empty';
                        },
                        label: 'Search',
                        type: TextInputType.text),
                    SizedBox(
                      height: 10,
                    ),
                    if (state is SearchLoadingState)
                      LinearProgressIndicator(
                        color: defaultColor,
                        backgroundColor: defaultColor.withOpacity(0.3),
                      ),
                    SizedBox(
                      height: 10,
                    ),
                    if (state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) => buildSearchItem(
                            SearchCubit.get(context)
                                .categoryProductsData!
                                .data!
                                .data![index],
                            context,
                          ),
                          separatorBuilder: (context, index) => Divider(),
                          itemCount: SearchCubit.get(context)
                              .categoryProductsData!
                              .data!
                              .data!
                              .length,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget buildSearchItem(
  ProductData model,
  context,
) =>
    InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductsDetailsScreen(model)));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 100,
          child: Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image(
                      image: NetworkImage(
                        model.image!,
                      ),
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.name!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          model.price!.toString(),
                          style: TextStyle(
                            color: defaultColor,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
