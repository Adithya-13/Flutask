
import 'package:flutask/presentation/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Center(
        child: LottieBuilder.asset(Resources.loading, height: MediaQuery.of(context).size.height * 0.2),
      ),
    );
  }
}

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Center(
        child: LottieBuilder.asset(Resources.empty, height: MediaQuery.of(context).size.height * 0.3),
      ),
    );
  }
}
