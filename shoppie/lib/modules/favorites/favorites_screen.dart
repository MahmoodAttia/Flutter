import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppie/layout/cubit/shop_cubit.dart';
import 'package:shoppie/layout/cubit/shop_state.dart';
import 'package:shoppie/models/favorites_model.dart';
import 'package:shoppie/shared/components/constants.dart';

class FavouritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ShopCubit.get(context).favoritesModel!.data!.data.isNotEmpty
            ? ListView.separated(
                itemBuilder: (context, index) {
                  return buildProductItem(
                    ShopCubit.get(context).favoritesModel!,
                    context,
                    index,
                  );
                },
                separatorBuilder: (context, index) {
                  return Container(
                    width: 1,
                    height: 1,
                    color: Colors.grey,
                  );
                },
                itemCount:
                    ShopCubit.get(context).favoritesModel!.data!.data.length)
            : Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(image: AssetImage('assets/images/nodataa.png')),
                      Text(
                        'We didn\'t find any favourite products!',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ]),
              );
      },
    );
  }
}

Widget buildProductItem(FavouritesModel model, context, int index) {
  return InkWell(
    onTap: () {
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => ProductsDetailsScreen(model)));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image(
                    image: NetworkImage(
                      model.data!.data[index].product!.image!,
                    ),
                    width: 100,
                    height: 100,
                    fit: BoxFit.contain,
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
                    model.data!.data[index].product!.name!,
                    maxLines: 2,
                    style: TextStyle(fontSize: 17),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        model.data!.data[index].product!.price!.toString(),
                        style: TextStyle(
                          color: defaultColor,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Spacer(),
                      IconButton(
                          onPressed: () {
                            ShopCubit.get(context).addToFavourite(
                                model.data!.data[index].product!.id);
                          },
                          icon: ShopCubit.get(context)
                                  .favs[model.data!.data[index].product!.id]!
                              ? Icon(
                                  Icons.favorite,
                                )
                              : Icon(
                                  Icons.favorite_outline,
                                ))
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
}
