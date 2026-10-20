part of 'home_bloc.dart';

@immutable
sealed class HomeState {
  const HomeState();
}

final class HomeInitial extends HomeState {
  const HomeInitial();
}

final class HomeLoading extends HomeState {
  const HomeLoading();
}

final class HomeLoaded extends HomeState {
  final List<HomeItem> items;
  final List<String> images;

  const HomeLoaded(this.items, this.images);
}

final class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);
}