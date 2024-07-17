import 'package:flutter/material.dart';
import 'models/table_cell_data.dart';

class DynamicTableCell extends StatelessWidget {
  final TableCellData cellData;
  final TextStyle cellTextStyle;
  final Function(dynamic)? onCellUpdate;
  final bool wrapContent;

  const DynamicTableCell({
    Key? key,
    required this.cellData,
    required this.cellTextStyle,
    this.onCellUpdate,
    this.wrapContent = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      constraints: BoxConstraints(minHeight: 48.0),
      child: cellData.customWidget ??
          TextFormField(
            readOnly: !cellData.isEditable,
            initialValue: cellData.content.toString(),
            onChanged: (value) {
              cellData.updateContent(value);
              if (onCellUpdate != null) {
                onCellUpdate!(value);
              }
            },
            maxLines: wrapContent ? null : 1,
            decoration: InputDecoration(border: InputBorder.none),
            style: cellTextStyle,
          ),
    );
  }
}
