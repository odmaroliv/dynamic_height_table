import 'package:dynamic_height_table/dynamic_height_table.dart.dart';
import 'package:flutter/material.dart';

class CustomTableCell extends StatelessWidget {
  final TableCellData cellData;
  final TextStyle cellTextStyle;
  final VoidCallback onPressed;

  const CustomTableCell({
    Key? key,
    required this.cellData,
    required this.cellTextStyle,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      constraints: BoxConstraints(minHeight: 48.0),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              readOnly: !cellData.isEditable,
              initialValue: cellData.content.toString(),
              onChanged: (value) {
                cellData.updateContent(value);
              },
              maxLines: null,
              decoration: InputDecoration(border: InputBorder.none),
              style: cellTextStyle,
            ),
          ),
          IconButton(
            icon: Icon(Icons.print),
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}
