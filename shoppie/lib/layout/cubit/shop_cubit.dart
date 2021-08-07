import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppie/models/add_to_cart_model.dart';
import 'package:shoppie/models/carts_model.dart';
import 'package:shoppie/models/change_fav.dart';
import 'package:shoppie/models/faqs_model.dart';
import 'package:shoppie/models/favorites_model.dart';
import 'package:shoppie/models/home_model.dart';
import 'package:shoppie/models/login_model.dart';
import 'package:shoppie/shared/components/constants.dart';
import 'package:shoppie/shared/local/shared_preferences.dart';
import 'package:shoppie/shared/remote/dio_helper.dart';

import 'shop_state.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(ShopInitial());
  static ShopCubit get(context) => BlocProvider.of(context);

  Map<int, bool> favs = {};
  Map<int, bool> cartProducts = {};

  HomeModel? homeModel;
  void getHomeData() async {
    emit(ShopLoadingHome());
    return await DioHelper.getData(path: 'home', headers: {
      'lang': 'en',
      'Content-Type': 'application/json',
      'Authorization': token,
    }).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products
          .forEach((e) => favs.addAll({e.id!: e.inFavourites!}));

      homeModel!.data!.products
          .forEach((e) => cartProducts.addAll({e.id!: e.inCart!}));

      emit(ShopGetSuccessHome());
    }).catchError((error) {
      print(error);
      emit(ShopErrorGetHome());
    });
  }

  ChangeFavModel? changeFavModel;
  void addToFavourite(int? id) {
    favs[id!] = !favs[id]!;
    emit(ShopLoadAddToFav());
    DioHelper.postData(
      path: 'favorites',
      headers: {
        'lang': 'en',
        'Content-Type': 'application/json',
        'Authorization': token,
      },
      data: {'product_id': id},
    ).then((value) {
      changeFavModel = ChangeFavModel.fromJson(value.data);
      print(changeFavModel!.message);
      getFavourites();
      emit(ShopAddToFav());
    }).catchError((error) {
      favs[id] = !favs[id]!;

      print(error);
      emit(ShopErrorAddToFav());
    });
  }

  FavouritesModel? favoritesModel;
  void getFavourites() {
    emit(ShopLoadingFavourites());
    DioHelper.getData(
      path: 'favorites',
      headers: {
        'lang': 'en',
        'Content-Type': 'application/json',
        'Authorization': token,
      },
    ).then((value) {
      favoritesModel = FavouritesModel.fromJson(value.data);
      emit(ShopGetSuccessFavourites());
    }).catchError((error) {
      print(error);
      emit(ShopErrorGetFavourites());
    });
  }

  Future logout() async {
    return await DioHelper.postData(
      path: 'logout',
      headers: {
        'lang': 'en',
        'Content-Type': 'application/json',
        'Authorization': token,
      },
    ).then((value) {
      CacheHelper.removeData(key: 'token');
      token = CacheHelper.getData(key: 'token');
      emit(ShopSuccessLogout());
    }).catchError((onError) {
      print(onError);
      emit(ShopErrorLogout());
    });
  }

  LoginModel? loginModel;
  Future userData() async {
    return await DioHelper.getData(
      path: 'profile',
      headers: {
        'lang': 'en',
        'Content-Type': 'application/json',
        'Authorization': token,
      },
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      print(loginModel!.data!.email);
      emit(ShopSuccessGetUserData());
    }).catchError((onError) {
      print(onError);
      emit(ShopErrorGetUserData());
    });
  }

  FAQ? faqModel;
  Future getFAQS() async {
    return await DioHelper.getData(
      path: 'faqs',
      headers: {
        'lang': 'en',
      },
    ).then((value) {
      faqModel = FAQ.fromJson(value.data);
      emit(ShopSuccessGetFaqs());
    }).catchError((onError) {
      print(onError);
      emit(ShopErrorGetFaqs());
    });
  }

  LoginModel? updateUserModel;

  Future updateUserData({
    required String name,
    required String phone,
    required String email,
    String? password,
  }) async {
    emit(ShopLoadingUpdateUserData());
    return await DioHelper.putData(path: 'update-profile', headers: {
      'lang': 'en',
      'Content-Type': 'application/json',
      'Authorization': token,
    }, data: {
      'name': name,
      'phone': phone,
      'email': email,
      'password': password
    }).then((value) {
      updateUserModel = LoginModel.fromJson(value.data);
      userData();
      print(updateUserModel!.message);
      emit(ShopSuccessUpdateUserData(updateUserModel!));
    }).catchError((onError) {
      print(onError);
      emit(ShopErrorUpdateUserData());
    });
  }

  int currentIndex = 0;
  void changeBottomNav(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  CartsModel? cartsModel;
  Future getCarts() {
    emit(ShopLoadingCarts());
    return DioHelper.getData(
      path: 'carts',
      headers: {
        'lang': 'en',
        'Content-Type': 'application/json',
        'Authorization': token,
      },
    ).then((value) {
      cartsModel = CartsModel.fromJson(value.data);

      print(cartsModel!.status);
      emit(ShopGetSuccessCarts());
    }).catchError((onError) {
      print(onError);
      emit(ShopErrorGetCarts());
    });
  }

  AddToCartModel? addToCartModel;

  Future addToCart({
    required int id,
  }) async {
    cartProducts[id] = !cartProducts[id]!;
    emit(ShopLoadingAddtoCart());
    return await DioHelper.postData(path: 'carts', headers: {
      'lang': 'en',
      'Content-Type': 'application/json',
      'Authorization': token,
    }, data: {
      'product_id': id
    }).then((value) {
      addToCartModel = AddToCartModel.fromJson(value.data);
      print(addToCartModel!.message!);
      getCarts();
      getHomeData();
      print(cartProducts);
      // if (addToCartModel!.status!) {
      //   getCarts();
      // }
      emit(ShopGetSuccessAddtoCart(addToCartModel!));
    }).catchError((onError) {
      cartProducts[id] = !cartProducts[id]!;

      print(onError);
      emit(ShopErrorAddtoCart());
    });
  }

  bool obsecure = true;
  IconData visibilityIcon = Icons.visibility;
  void changeVisibility() {
    obsecure = !obsecure;
    obsecure
        ? visibilityIcon = Icons.visibility
        : visibilityIcon = Icons.visibility_off;
    emit(HomeChangeVisiblityState());
  }

  AddToCartModel? addQuantityModel;
  Future addQuantity({
    required int quantity,
    required int id,
  }) {
    return DioHelper.putData(
      path: 'carts/$id',
      data: {'quantity': quantity},
      headers: {
        'lang': 'en',
        'Content-Type': 'application/json',
        'Authorization': token,
      },
    ).then((value) {
      emit(ShopSuccessAddQuantity());
    }).catchError((onError) {
      emit(ShopErrorAddQuantity());
    });
  }
}
