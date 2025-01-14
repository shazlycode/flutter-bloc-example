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
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    context.read<NewsCubit>().fetchNews();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<NewsCubit, NewsState>(builder: (context, state) {
        if (state is NewsLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is NewsFechingSuccess) {
          List news = context.read<NewsCubit>().news;

          return ListView.builder(
              itemCount: news.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(news[index]['title']),
                );
              });
        } else if (state is NewsFetchingFailure) {
          return Center(
            child: Text("${state.failureError}"),
          );
        }
        {
          return Center(child: Text('No data available'));
        }
      }),
    );
  }
}
