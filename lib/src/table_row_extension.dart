import 'package:flutter/material.dart';

extension TableRowExtension on TableRow {
  Widget toWidget() {
    return Table(
      children: [this],
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
    );
  }
}
