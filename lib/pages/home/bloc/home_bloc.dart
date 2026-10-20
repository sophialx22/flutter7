import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/home_item.dart';
import '../../../mock/home_data.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeInitial()) {
    on<LoadHomeData>(_onLoadHomeData);
  }

  Future<void> _onLoadHomeData(
      LoadHomeData event,
      Emitter<HomeState> emit,
      ) async {
    emit(const HomeLoading());

    try {
      await Future.delayed(const Duration(milliseconds: 500));

      emit(HomeLoaded(homeItems, homeImages));
    } catch (e) {
      emit(const HomeError('Не удалось загрузить данные'));
    }
  }
}