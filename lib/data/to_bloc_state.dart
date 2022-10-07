abstract class ToBlocState {}

class InitialState extends ToBlocState {}

class ToCurrencyPicked extends ToBlocState {
  final String to;
  final String toImage;
  ToCurrencyPicked({required this.to, required this.toImage});
}
