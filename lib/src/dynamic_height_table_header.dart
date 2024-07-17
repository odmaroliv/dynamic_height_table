import 'package:flutter/material.dart';

class DynamicHeightTableHeader extends StatelessWidget {
  final List<String> columnHeaders;
  final TextStyle? headerStyle;
  final Color? headerColor;
  final bool additionalActions;

  DynamicHeightTableHeader({
    required this.columnHeaders,
    this.headerStyle,
    this.headerColor,
    this.additionalActions = false,
  });

  @override
  Widget build(BuildContext context) {
    return Table(
      children: [buildHeaderRow(context)],
    );
  }

  TableRow buildHeaderRow(BuildContext context) {
    return TableRow(
      decoration: BoxDecoration(color: headerColor ?? Colors.grey[200]),
      children: columnHeaders.map((header) {
        return TableCell(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              header,
              style: headerStyle ??
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
              softWrap: true,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      }).toList()
        ..add(additionalActions
            ? _buildActionHeader()
            : TableCell(child: Container())),
    );
  }

  TableCell _buildActionHeader() {
    return TableCell(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'Actions',
          style: headerStyle ??
              TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
          softWrap: true,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
