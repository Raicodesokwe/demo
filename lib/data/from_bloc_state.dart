abstract class FromBlocState {}

class InitialFromState extends FromBlocState {}

class FromCurrencyPicked extends FromBlocState {
  final String from;
  final String fromImage;
  FromCurrencyPicked({required this.from, required this.fromImage});
}
