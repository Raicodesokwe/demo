import 'package:demoapp/models/currency_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/to_currency_cubit.dart';

class ToOverlay extends StatefulWidget {
  const ToOverlay({Key? key}) : super(key: key);

  @override
  State<ToOverlay> createState() => _ToOverlayState();
}

class _ToOverlayState extends State<ToOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final convert = context.read<ToCurrencyCubit>();
    return ScaleTransition(
      scale: scaleAnimation,
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'To',
          style: TextStyle(fontSize: 30),
        ),
        content: Padding(
          padding: const EdgeInsets.all(8),
          child: Wrap(
            spacing: 25,
            runSpacing: 15,
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.start,
            direction: Axis.horizontal,
            runAlignment: WrapAlignment.start,
            verticalDirection: VerticalDirection.down,
            clipBehavior: Clip.none,
            children: List.generate(currencyList.length, (index) {
              final tolist = currencyList[index];
              return GestureDetector(
                onTap: () {
                  convert.selectToCurrency(index);
                  Navigator.of(context).pop();
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image:
                                  AssetImage("assets/images/${tolist.image}")),
                          color: Colors.white54,
                          shape: BoxShape.circle),
                    ),
                    Text(tolist.name)
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
