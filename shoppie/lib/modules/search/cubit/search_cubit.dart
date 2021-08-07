import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shoppie/models/category_data_model.dart';
import 'package:shoppie/shared/components/constants.dart';
import 'package:shoppie/shared/remote/dio_helper.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());
  static SearchCubit get(context) => BlocProvider.of(context);

  CategoryProductsData? categoryProductsData;
  void searchProducts(String text) {
    emit(SearchLoadingState());
    DioHelper.postData(
      path: 'products/search',
      data: {'text': text},
      headers: {
        'lang': 'en',
        'Content-Type': 'application/json',
        'Authorization': token,
      },
    ).then((value) {
      emit(SearchSuccessState());

      categoryProductsData = CategoryProductsData.fromJson(value.data);
    }).catchError((onError) {
      print(onError);
      emit(SearchErrorState());
    });
  }
}
