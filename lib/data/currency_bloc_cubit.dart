import 'package:demoapp/api/api_repository.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'currency_bloc_state.dart';

class CurrencyBlocCubit extends Cubit<CurrencyBlocState> {
  final ApiRepository _repository;
  CurrencyBlocCubit(this._repository) : super(InitCurrencyBlocState());

  Future<void> changeCurrency(
      {String? to, String? from, String? amount}) async {
    emit(LoadingCurrencyBlocState());
    try {
      final response =
          await _repository.convertCurrency(to: to, from: from, amount: amount);

      emit(ResponseCurrencyBlocState(response));
    } on Exception catch (e) {
      emit(ErrorCurrencyBlocState(e.toString()));
    }
  }
}
