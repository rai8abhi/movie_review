import 'package:flutter/material.dart';

import '../helper/responsive_ui.dart';

class RowSpacer extends StatelessWidget {
  final double value;
  const RowSpacer({
    Key? key,
    this.value = 3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ResponsiveUI().width(value),
    );
  }
}
