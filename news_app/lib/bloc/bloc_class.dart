import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/bloc_states.dart';
import 'package:news_app/modules/business.dart';
import 'package:news_app/modules/science.dart';
import 'package:news_app/modules/sports.dart';
import 'package:news_app/network/remote/dio.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(InitialState());
  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Business'),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sports'),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Science'),
  ];
  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];
  void changeNav(int index) {
    currentIndex = index;
    emit(BottomNavState());
    if (currentIndex == 1) {
      getSportsData();
    }
    if (currentIndex == 2) {
      getScienceData();
    }
  }

  List<dynamic> business = [];
  Future getBusinessData() async {
    emit(BusinessLoadingState());
    return await DioHelper.getData(url: 'v2/top-headlines', queries: {
      'country': 'eg',
      'category': 'business',
      'apiKey': 'ac03323163974c35a68e17de5d6fc585',
    }).then((value) {
      business = value.data['articles'];
      emit(GetBusinessDataState());
    }).catchError((error) {
      print(error.toString());
      emit(BusinessErrorState());
    });
  }

  List<dynamic> sports = [];
  Future getSportsData() async {
    emit(SportsLoadingState());
    if (sports.length == 0) {
      return await DioHelper.getData(url: 'v2/top-headlines', queries: {
        'country': 'eg',
        'category': 'sports',
        'apiKey': 'ac03323163974c35a68e17de5d6fc585',
      }).then((value) {
        sports = value.data['articles'];
        emit(GetSportsDataState());
      }).catchError((error) {
        print(error.toString());
        emit(SportsErrorState());
      });
    } else {
      emit(GetSportsDataState());
    }
  }

  List<dynamic> science = [];
  Future getScienceData() async {
    emit(ScienceLoadingState());
    if (science.isEmpty) {
      return await DioHelper.getData(url: 'v2/top-headlines', queries: {
        'country': 'eg',
        'category': 'science',
        'apiKey': 'ac03323163974c35a68e17de5d6fc585',
      }).then((value) {
        science = value.data['articles'];
        emit(GetScienceDataState());
      }).catchError((error) {
        print(error.toString());
        emit(ScienceErrorState());
      });
    } else {
      emit(GetScienceDataState());
    }
  }

  bool isDark = false;
  void changeMood() {
    isDark = !isDark;
    emit(ChangeMoodState());
  }
}
