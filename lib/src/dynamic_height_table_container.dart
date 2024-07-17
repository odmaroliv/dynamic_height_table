import 'package:dynamic_height_table/dynamic_height_table.dart.dart';
import 'package:flutter/material.dart';
import 'models/table_cell_data.dart';
import 'models/table_row_data.dart';

typedef CellContentBuilder = Widget Function(
    int rowIndex, int columnIndex, TableCellData cellData);
typedef AddRowCallback = void Function();
typedef DeleteRowCallback = void Function(int rowIndex);

class DynamicTable extends StatelessWidget {
  final List<TableRowData> data;
  final List<String> headers;
  final Color headerColor;
  final Color cellColor;
  final TextStyle headerTextStyle;
  final TextStyle cellTextStyle;
  final double elevation;
  final bool wrapContent;
  final CellContentBuilder? cellContentBuilder;
  final AddRowCallback? onAddRow;
  final DeleteRowCallback? onDeleteRow;

  DynamicTable({
    Key? key,
    required this.data,
    required this.headers,
    this.headerColor = Colors.blueGrey,
    this.cellColor = Colors.white,
    this.headerTextStyle =
        const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
    this.cellTextStyle = const TextStyle(color: Colors.black87),
    this.elevation = 4.0,
    this.wrapContent = false,
    this.cellContentBuilder,
    this.onAddRow,
    this.onDeleteRow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int numColumns = headers.length;
    return Material(
      elevation: elevation,
      child: SingleChildScrollView(
        child: Table(
          columnWidths: const {0: FlexColumnWidth()},
          border: TableBorder.all(color: Colors.grey),
          children: [
            TableRow(
              children: headers
                  .map((header) => TableCell(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          color: headerColor,
                          child: Text(header,
                              style: headerTextStyle ??
                                  TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ))
                  .toList(),
            ),
            ...data.asMap().entries.map((entry) {
              int rowIndex = entry.key;
              TableRowData rowData = entry.value;
              return DynamicTableRow(
                rowData: rowData,
                cellTextStyle: cellTextStyle,
                cellColor: cellColor,
                numColumns: numColumns,
                wrapContent: wrapContent,
                cellContentBuilder: cellContentBuilder,
                onDeleteRow: onDeleteRow,
                rowIndex: rowIndex,
              ).buildTableRow();
            }).toList(),
            if (onAddRow != null)
              TableRow(
                children: [
                  TableCell(
                    child: IconButton(
                      icon: Icon(Icons.add),
                      onPressed: onAddRow,
                    ),
                  ),
                  ...List.generate(
                      numColumns - 1, (index) => TableCell(child: Container())),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
