import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppie/layout/cubit/shop_cubit.dart';
import 'package:shoppie/layout/cubit/shop_state.dart';
import 'package:shoppie/models/category_data_model.dart';

class CategoryProducsScreen extends StatelessWidget {
  final CategoryProductsData model;

  const CategoryProducsScreen(this.model);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
        listener: (context, state) {},
        builder: (context, state) {
          List<ProductData> favModel = model.data!.data!;
          return Scaffold(
            appBar: AppBar(),
            body: buildHomeLayout(favModel, context, state),
          );
        });
  }

  Widget buildHomeLayout(List<ProductData> model, context, state) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Text(name),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                childAspectRatio: 1 / 1.6,
                children: List.generate(model.length,
                    (index) => buildProducts(index, model[index], context)),
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProducts(int index, ProductData data, context) {
    return InkWell(
      onTap: () {
        print('object');
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(10), boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
          )
        ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Center(
                      child: Image(
                        height: 170,
                        fit: BoxFit.contain,
                        image: NetworkImage(data.image!),
                      ),
                    ))),
            SizedBox(height: 10),
            Text(
              data.name!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style:
                  Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 16),
            ),
            Row(
              children: [
                Text(
                  '\$${data.price!}',
                  style: TextStyle(color: Colors.grey),
                ),
                Spacer(),
                IconButton(
                    onPressed: () {
                      ShopCubit.get(context).addToFavourite(data.id);
                    },
                    icon: ShopCubit.get(context).favs[data.id]!
                        ? Icon(Icons.favorite)
                        : Icon(
                            Icons.favorite_outline,
                          ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
