class CurrencyModel {
  final String name;
  final String image;
  CurrencyModel({required this.name, required this.image});
}

List<CurrencyModel> currencyList = [
  CurrencyModel(name: 'USD', image: 'usflag.jpg'),
  CurrencyModel(name: 'ZAR', image: 'sa.jpg'),
  CurrencyModel(name: 'EUR', image: 'euro.png'),
  CurrencyModel(name: 'GBP', image: 'uk.png'),
  CurrencyModel(name: 'AUD', image: 'aus.jpg'),
  CurrencyModel(name: 'JPY', image: 'japan.png'),
];
