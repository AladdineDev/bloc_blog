import 'package:flutter/material.dart';

class Spinner extends StatelessWidget {
  const Spinner.small({
    super.key,
    this.strokeWidth = 2,
    this.dimension = 20,
  });

  const Spinner.medium({
    super.key,
    this.strokeWidth = 4,
    this.dimension = 36,
  });

  final double strokeWidth;
  final double dimension;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.square(
        dimension: dimension,
        child: CircularProgressIndicator(
          strokeWidth: strokeWidth,
        ),
      ),
    );
  }
}
