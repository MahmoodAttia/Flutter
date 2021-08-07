import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppie/layout/cubit/shop_cubit.dart';
import 'package:shoppie/layout/cubit/shop_state.dart';
import 'package:shoppie/shared/components/components.dart';
import 'package:shoppie/shared/components/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductsDetailsScreen extends StatelessWidget {
  final dynamic model;

  const ProductsDetailsScreen(this.model);
  @override
  Widget build(BuildContext context) {
    var pageController = PageController();
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30))),
                  width: double.infinity,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          width: 400,
                          height: 500,
                          child: PageView.builder(
                            itemCount: model.images!.length,
                            itemBuilder: (context, index) => Image(
                              image: NetworkImage(model.images![index]),
                              fit: BoxFit.contain,
                            ),
                            controller: pageController,
                          ),
                        ),
                      ),
                      Positioned(
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Container(
                              width: 100,
                              height: 100,
                              child: Icon(
                                Icons.arrow_back_ios_new,
                                color: Colors.black,
                                size: 20,
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                            )),
                        top: 30,
                        left: 10,
                      ),
                      Positioned(
                        bottom: 30,
                        child: Center(
                          child: SmoothPageIndicator(
                            controller: pageController,
                            count: model.images!.length,
                            effect: ExpandingDotsEffect(
                                spacing: 8.0,
                                radius: 4.0,
                                dotWidth: 16.0,
                                dotHeight: 8.0,
                                strokeWidth: 1.5,
                                dotColor: Colors.grey,
                                activeDotColor: Colors.indigo),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.name!,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 25),
                      ),
                      Text(
                        model.description!,
                        //maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(fontSize: 17, color: Colors.grey[500]),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            child: Icon(
                              Icons.location_history,
                              color: defaultColor,
                            ),
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Zagazig, AlSharqiya',
                                style: TextStyle(
                                    fontSize: 17, color: Colors.grey[500]),
                              ),
                              Text(
                                '17.0.01, Zagazig',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(
                                        fontSize: 17, color: Colors.grey[500]),
                              ),
                            ],
                          ),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        '\$${model.price!}',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Text(
                        'Tax Rate 2\% -\$4.00 (\~ \$${model.price})',
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(fontSize: 17, color: Colors.grey[500]),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(8.0),
            child: defaultButton(
                color: ShopCubit.get(context).cartProducts[model.id!]!
                    ? Colors.green
                    : defaultColor,
                text: ShopCubit.get(context).cartProducts[model.id!]!
                    ? 'Added to cart!'
                    : 'Add To Cart',
                context: context,
                width: double.infinity,
                radius: 0,
                onPressed: () {
                  ShopCubit.get(context).addToCart(id: model.id!);
                }),
          ),
        );
      },
    );
  }
}
