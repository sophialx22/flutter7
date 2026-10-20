part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {
  const HomeEvent();
}

final class LoadHomeData extends HomeEvent {
  const LoadHomeData();
}