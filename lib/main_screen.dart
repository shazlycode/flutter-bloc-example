import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/bloc/cubit/news_cubit.dart';
import 'package:myapp/bloc/cubit/news_state.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<NewsCubit>().fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    List news = context.read<NewsCubit>().news;
    return Scaffold(
        appBar: AppBar(),
        body: ModalProgressHUD(
            inAsyncCall: isLoading,
            child: BlocBuilder<NewsCubit, NewsState>(builder: (context, state) {
              if (state is NewsLoading) {
                isLoading = true;
              } else if (state is NewsFetchingFailure) {
                isLoading = false;
                return Center(
                  child: Text(state.failureError.toString()),
                );
              } else if (state is NewsFechingSuccess) {
                isLoading = false;
                return ListView.builder(
                    itemCount: news.length,
                    itemBuilder: (context, index) {
                      return ListTile(title: Text(news[index]));
                    });
              } else {
                return Container();
              }
              return Container(
                child: const Text("Hello"),
              );
            })));
  }
}
