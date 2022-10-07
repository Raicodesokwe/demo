import 'package:demoapp/widgets/from_overlay.dart';
import 'package:demoapp/widgets/to_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../data/currency_bloc_cubit.dart';
import '../data/currency_bloc_state.dart';
import '../data/from_bloc_state.dart';
import '../data/from_currency_cubit.dart';
import '../data/to_bloc_state.dart';
import '../data/to_currency_cubit.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool selected = false;

  late String amount;

  final TextEditingController amountController = TextEditingController();

  String changedAmount = '';

  String? toCurrency;
  String? fromCurrency;

  @override
  Widget build(BuildContext context) {
    final convert = context.read<CurrencyBlocCubit>();

    Size size = MediaQuery.of(context).size;
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isKeyboard)
              const Text(
                'Currency\nConverter',
                style: TextStyle(fontSize: 35),
              ),
            SizedBox(
              height: size.height * 0.1,
            ),
            Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  controller: amountController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a valid amount';
                    }

                    return null;
                  },
                  onChanged: (value) {
                    amount = value;
                  },
                  cursorColor: Colors.black45,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: 'Enter amount',
                      hintStyle: GoogleFonts.prompt(),
                      border: InputBorder.none),
                )),
            SizedBox(
              height: size.height * 0.03,
            ),
            Row(
              children: [
                Text('From:'),
                SizedBox(
                  width: 7,
                ),
                BlocBuilder<FromCurrencyCubit, FromCurrencyPicked>(
                    builder: (context, state) {
                  fromCurrency = state.from;
                  return ActionChip(
                    onPressed: () {
                      showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (context) {
                            return FromOverlay();
                          });
                    },
                    side: BorderSide(color: Colors.black, width: 1),
                    labelPadding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    label: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      "assets/images/${state.fromImage}")),
                              color: Colors.white54,
                              shape: BoxShape.circle),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          state.from,
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                    backgroundColor: Colors.transparent,
                  );
                }),
                Spacer(),
                Text('To:'),
                SizedBox(
                  width: 7,
                ),
                BlocBuilder<ToCurrencyCubit, ToCurrencyPicked>(
                    builder: (context, state) {
                  toCurrency = state.to;
                  return ActionChip(
                    onPressed: () {
                      showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (context) {
                            return ToOverlay();
                          });
                    },
                    side: BorderSide(color: Colors.black, width: 1),
                    labelPadding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    label: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      "assets/images/${state.toImage}")),
                              color: Colors.white54,
                              shape: BoxShape.circle),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          state.to,
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                    backgroundColor: Colors.transparent,
                  );
                }),
              ],
            ),
            SizedBox(
              height: size.height * 0.07,
            ),
            selected
                ? Row(
                    children: [
                      Text(
                        'They\'ll receive . . .',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      BlocBuilder<CurrencyBlocCubit, CurrencyBlocState>(
                          builder: (context, state) {
                        if (state is InitCurrencyBlocState) {
                          return Container();
                        } else if (state is LoadingCurrencyBlocState) {
                          return Shimmer.fromColors(
                              child: Container(
                                width: 100,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.pink.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(7)),
                              ),
                              baseColor: Colors.pink.withOpacity(0.7),
                              highlightColor: Colors.pink.withOpacity(0.3));
                        } else if (state is ResponseCurrencyBlocState) {
                          changedAmount = state.response.result!
                              .toStringAsFixed(2)
                              .toString();
                          return Text(
                            toCurrency == 'USD'
                                ? '\$$changedAmount'
                                : toCurrency == 'GBP'
                                    ? '￡$changedAmount'
                                    : toCurrency == 'ZAR'
                                        ? 'ZAR $changedAmount'
                                        : toCurrency == 'EUR'
                                            ? '€$changedAmount'
                                            : toCurrency == 'JPY'
                                                ? '¥$changedAmount'
                                                : toCurrency == 'AUD'
                                                    ? 'AUD\$$changedAmount'
                                                    : changedAmount,
                            style: TextStyle(fontSize: 18),
                          );
                        }
                        return Container();
                      }),
                    ],
                  )
                : Center(
                    child: Text(
                    'They\'ll receive . . .',
                    style: TextStyle(fontSize: 18),
                  )),
            SizedBox(
              height: size.height * 0.07,
            ),
            amountController.text.isEmpty
                ? Center(
                    child: Container(
                      height: 100,
                      width: 100,
                      child: Center(
                        child: Icon(
                          Icons.swap_horiz,
                          size: 55,
                        ),
                      ),
                      decoration: BoxDecoration(
                          // shape: BoxShape.circle,
                          border: Border.all(color: Colors.pink, width: 4)),
                    ),
                  )
                : Center(
                    child: GestureDetector(
                      onTap: () {
                        convert.changeCurrency(
                            to: toCurrency, from: fromCurrency, amount: amount);
                        setState(() {
                          selected = true;
                        });
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        child: Center(
                          child: Icon(
                            Icons.swap_vert,
                            size: 55,
                            color: Colors.white,
                          ),
                        ),
                        decoration: BoxDecoration(
                            // shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.pink.withAlpha(225),
                                  blurRadius: 45,
                                  spreadRadius: 15,
                                  offset: Offset(0, 0))
                            ],
                            gradient: LinearGradient(
                                colors: [Colors.pink, Colors.pinkAccent],
                                begin: Alignment.centerRight,
                                end: Alignment.centerLeft),
                            border: Border.all(color: Colors.pink, width: 4)),
                      ),
                    ),
                  ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
