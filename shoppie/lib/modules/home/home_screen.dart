import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:shoppie/layout/cubit/shop_cubit.dart';
import 'package:shoppie/layout/cubit/shop_state.dart';
import 'package:shoppie/models/home_model.dart';
import 'package:shoppie/modules/product/product_screen.dart';
import 'package:shoppie/shared/components/constants.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              body: Conditional.single(
                  context: context,
                  conditionBuilder: (context) =>
                      ShopCubit.get(context).homeModel != null &&
                      ShopCubit.get(context).favs.isNotEmpty,
                  widgetBuilder: (context) => buildHomeLayout(context, state),
                  fallbackBuilder: (context) => Center(
                        child: CircularProgressIndicator(),
                      )));
        });
  }

  Widget buildHomeLayout(context, state) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CarouselSlider.builder(
            itemCount: 4,
            itemBuilder: (context, int index, t) => Image(
              width: double.infinity,
              image: NetworkImage(
                ShopCubit.get(context).homeModel!.data!.banners[index].image!,
              ),
              fit: BoxFit.cover,
            ),
            options: CarouselOptions(
              autoPlay: true,
              viewportFraction: 1,
              autoPlayAnimationDuration: Duration(seconds: 2),
              autoPlayCurve: Curves.easeInOut,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 15,
          ),
          Conditional.single(
              context: context,
              conditionBuilder: (context) => state is! ShopLoadingHome,
              widgetBuilder: (context) => Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      child: GridView.count(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        childAspectRatio: 1 / 1.6,
                        children: List.generate(
                            ShopCubit.get(context)
                                .homeModel!
                                .data!
                                .products
                                .length,
                            (index) => buildProducts(
                                ShopCubit.get(context)
                                    .homeModel!
                                    .data!
                                    .products,
                                index,
                                context)),
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                    ),
                  ),
              fallbackBuilder: (context) => Center(
                    child: CircularProgressIndicator(),
                  ))
        ],
      ),
    );
  }

  Widget buildProducts(List<ProductsModel> data, int index, context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductsDetailsScreen(data[index])));
      },
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[100]!.withOpacity(0.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Center(
                          child: Image(
                            height: 170,
                            fit: BoxFit.contain,
                            image: NetworkImage(data[index].image!),
                          ),
                        ))),
                if (data[index].discount! != 0)
                  Container(
                    width: double.infinity,
                    color: defaultColor,
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Text(
                      'Discount',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 15, color: Colors.white),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: Text(
                data[index].name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 16),
              ),
            ),
            Row(
              children: [
                Text(
                  '\$${data[index].price!}  ',
                  style: TextStyle(color: Colors.grey),
                ),
                if (data[index].discount != 0)
                  Text(
                    '\$${data[index].oldprice!}',
                    style: TextStyle(
                        color: Colors.grey.withOpacity(0.5),
                        decoration: TextDecoration.lineThrough),
                  ),
                Spacer(),
                // IconButton(
                //     onPressed: () {
                //       // ShopCubit.get(context).addToFavourite(data[index].id);
                //     },
                //     icon: ShopCubit.get(context).cartProducts[data[index].id]!
                //         ? Icon(
                //             Icons.shopping_bag,
                //           )
                //         : Icon(
                //             Icons.shopping_bag_outlined,
                //           )),
                IconButton(
                    onPressed: () {
                      ShopCubit.get(context).addToFavourite(data[index].id);
                    },
                    icon: ShopCubit.get(context).favs[data[index].id]!
                        ? Icon(
                            Icons.favorite,
                          )
                        : Icon(
                            Icons.favorite_outline,
                          )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
