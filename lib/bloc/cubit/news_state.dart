abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsFechingSuccess extends NewsState {}

class NewsFetchingFailure extends NewsState {
  final String? failureError;

  NewsFetchingFailure({required this.failureError});
}
