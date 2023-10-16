import 'package:flutter/material.dart';

import '../helper/responsive_ui.dart';

class ColumnSpacer extends StatelessWidget {
  final double value;
  const ColumnSpacer({
    Key? key,
    this.value = 3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ResponsiveUI().height(value),
    );
  }
}
