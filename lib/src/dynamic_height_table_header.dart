import 'package:flutter/material.dart';

class DynamicTableHeader extends StatelessWidget {
  final List<String> headers;
  final TextStyle? headerStyle;

  const DynamicTableHeader({
    Key? key,
    required this.headers,
    this.headerStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        TableRow(
          children: headers
              .map((header) => TableCell(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(header,
                          style: headerStyle ??
                              TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                    ),
                  ))
              .toList(),
        )
      ],
    );
  }
}
