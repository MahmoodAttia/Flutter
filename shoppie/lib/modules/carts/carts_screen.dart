import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppie/layout/cubit/shop_cubit.dart';
import 'package:shoppie/layout/cubit/shop_state.dart';
import 'package:shoppie/models/carts_model.dart';
import 'package:shoppie/modules/confirm_order/confirm_order.dart';
import 'package:shoppie/modules/product/product_screen.dart';
import 'package:shoppie/shared/components/components.dart';
import 'package:shoppie/shared/components/constants.dart';

class CartsScreen extends StatefulWidget {
  @override
  _CartsScreenState createState() => _CartsScreenState();
}

class _CartsScreenState extends State<CartsScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          key: scaffoldKey,
          body: ShopCubit.get(context).cartsModel!.data!.cartItems!.isNotEmpty
              ? ListView.separated(
                  itemBuilder: (context, index) {
                    return buildProductItem(
                      ShopCubit.get(context)
                          .cartsModel!
                          .data!
                          .cartItems![index],
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
                  itemCount: ShopCubit.get(context)
                      .cartsModel!
                      .data!
                      .cartItems!
                      .length)
              : Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                            image: AssetImage('assets/images/empty_cart.png')),
                        Text(
                          'Your cart is empty, browse more!',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ]),
                ),
          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                color: Colors.grey[100],
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Container(
                      child: Text(
                        'Total: \n\$${ShopCubit.get(context).cartsModel!.data!.total}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 17),
                      ),
                    ),
                    Spacer(),
                    defaultButton(
                        onPressed: () {
                          if (ShopCubit.get(context).cartsModel!.data!.total! >
                              0)
                            scaffoldKey.currentState!
                                .showBottomSheet((context) => Container(
                                      color: Colors.grey[100],
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              width: double.infinity,
                                              color: Colors.grey[100],
                                              child: Text(
                                                'Total price: ${ShopCubit.get(context).cartsModel!.data!.total}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Text(
                                              'Choose payment method: ',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Row(
                                              children: [
                                                buildPay(
                                                    context,
                                                    Icons.money_rounded,
                                                    'Cash on delivery'),
                                                buildPay(context,
                                                    Icons.money_off, 'Online'),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            defaultButton(
                                                radius: 0,
                                                width: double.infinity,
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ConfirmOrderScreen()));
                                                },
                                                text: 'Confirm',
                                                context: context)
                                          ],
                                        ),
                                      ),
                                    ));
                        },
                        text: 'CHECKOUT',
                        context: context,
                        radius: 0)
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

Widget buildPay(context, icon, text) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: defaultColor,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              text,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    ),
  );
}

Widget buildProductItem(CartItems model, context, int index) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductsDetailsScreen(model.product)));
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
                      model.product!.image!,
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
                    model.product!.name!,
                    maxLines: 2,
                    style: TextStyle(fontSize: 17),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        '\$${model.product!.price!}',
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
                            ShopCubit.get(context)
                                .addToCart(id: model.product!.id!)
                                .then((value) {
                              ShopCubit.get(context).getCarts();
                              ShopCubit.get(context).getHomeData();
                            });
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          )),
                      TextButton(
                          onPressed: () {
                            ShopCubit.get(context)
                                .addQuantity(
                                    quantity: model.quantity! + 1,
                                    id: model.id!)
                                .then((value) =>
                                    ShopCubit.get(context).getCarts());
                          },
                          child: Icon(Icons.add)),
                      Text('${model.quantity}'),
                      TextButton(
                          onPressed: () {
                            if (model.quantity! >= 1) {
                              ShopCubit.get(context)
                                  .addQuantity(
                                      quantity: model.quantity! - 1,
                                      id: model.id!)
                                  .then((value) =>
                                      ShopCubit.get(context).getCarts());
                            }
                            if (model.quantity! == 1) {
                              ShopCubit.get(context)
                                  .addToCart(id: model.product!.id!)
                                  .then((value) =>
                                      ShopCubit.get(context).getCarts());
                            }
                          },
                          child: Icon(Icons.remove)),
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
