import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return const Center(
      child: SizedBox(
        width: 200,
        height: 200,
        child: LoadingIndicator(
          indicatorType: Indicator.lineScale,
          colors: [
            Colors.red,
            Colors.brown,
            Colors.yellow,
            Colors.green,
            Colors.blue,
          ],
        ),
      ),
    );
  }
}
