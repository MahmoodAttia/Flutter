import '../../models/add_to_cart_model.dart';
import '../../models/login_model.dart';

abstract class ShopState {}

class ShopInitial extends ShopState {}

class ShopChangeBottomNavState extends ShopState {}

class ChangeCategoryButtonState extends ShopState {}

class ShopLoadingFavourites extends ShopState {}

class ShopGetSuccessFavourites extends ShopState {}

class ShopErrorGetFavourites extends ShopState {}

class ShopAddToFav extends ShopState {}

class ShopLoadAddToFav extends ShopState {}

class ShopErrorAddToFav extends ShopState {}

class ShopLoadingHome extends ShopState {}

class ShopGetSuccessHome extends ShopState {}

class ShopErrorGetHome extends ShopState {}

class ShopSuccessLogout extends ShopState {}

class ShopErrorLogout extends ShopState {}

class ShopSuccessGetUserData extends ShopState {}

class ShopErrorGetUserData extends ShopState {}

class ShopSuccessUpdateUserData extends ShopState {
  final LoginModel updateModel;

  ShopSuccessUpdateUserData(this.updateModel);
}

class ShopErrorUpdateUserData extends ShopState {}

class ShopLoadingUpdateUserData extends ShopState {}

class HomeChangeVisiblityState extends ShopState {}

class ShopSuccessGetFaqs extends ShopState {}

class ShopErrorGetFaqs extends ShopState {}

// Carts
class ShopLoadingCarts extends ShopState {}

class ShopGetSuccessCarts extends ShopState {}

class ShopErrorGetCarts extends ShopState {}

class ShopLoadingAddtoCart extends ShopState {}

class ShopGetSuccessAddtoCart extends ShopState {
  final AddToCartModel addToCartModel;

  ShopGetSuccessAddtoCart(this.addToCartModel);
}

class ShopErrorAddtoCart extends ShopState {}

class ShopSuccessAddQuantity extends ShopState {}

class ShopErrorAddQuantity extends ShopState {}
