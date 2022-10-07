import 'package:demoapp/data/to_bloc_state.dart';
import 'package:demoapp/models/currency_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ToCurrencyCubit extends Cubit<ToCurrencyPicked> {
  ToCurrencyCubit() : super(ToCurrencyPicked(to: 'GBP', toImage: 'uk.png'));
  String? selectedtocurrency;
  String? selectedtoimage;
  void selectToCurrency(int tocurrency) {
    selectedtocurrency = currencyList[tocurrency].name;
    selectedtoimage = currencyList[tocurrency].image;

    emit(ToCurrencyPicked(to: selectedtocurrency!, toImage: selectedtoimage!));
  }
}
