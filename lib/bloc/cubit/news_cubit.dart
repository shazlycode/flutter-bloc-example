import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/bloc/cubit/news_state.dart';
import 'package:http/http.dart' as http;

import '../../constants/app_constants.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitial());
  List news = [];

  Future fetchNews() async {
    emit(NewsLoading());
    try {
      final response = await http.get(Uri.parse(baseUrl));
      List fetched = [];
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['articles'];
        print(data);
        for (int i = 0; i < data.length; i++) {
          // fetched.add(data.map((e) => e).toList());
        }
        fetched.addAll(["1", "$data", "Ahmed", "${response.statusCode}"]);
        news = fetched;
        emit(NewsFechingSuccess());
      } else {
        emit(NewsFetchingFailure(failureError: (response.body).toString()));
      }
    } catch (err) {
      emit(NewsFetchingFailure(failureError: err.toString()));
      rethrow;
    }
  }
}
