import 'package:demoapp/models/currency_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'from_bloc_state.dart';

class FromCurrencyCubit extends Cubit<FromCurrencyPicked> {
  FromCurrencyCubit()
      : super(FromCurrencyPicked(from: 'USD', fromImage: 'usflag.jpg'));
  String? selectedfromcurrency;
  String? selectedfromimage;
  void selectFromCurrency(int fromcurrency) {
    selectedfromcurrency = currencyList[fromcurrency].name;
    selectedfromimage = currencyList[fromcurrency].image;

    emit(FromCurrencyPicked(
        from: selectedfromcurrency!, fromImage: selectedfromimage!));
  }
}
