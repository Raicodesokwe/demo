import 'package:demoapp/models/currency_change_model.dart';

abstract class CurrencyBlocState {}

class InitCurrencyBlocState extends CurrencyBlocState {}

class LoadingCurrencyBlocState extends CurrencyBlocState {}

class ErrorCurrencyBlocState extends CurrencyBlocState {
  final String errorMessage;
  ErrorCurrencyBlocState(this.errorMessage);
}

class ResponseCurrencyBlocState extends CurrencyBlocState {
  CurrencyChangeModel response;
  ResponseCurrencyBlocState(this.response);
}
