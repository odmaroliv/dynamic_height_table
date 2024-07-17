import 'package:dynamic_height_table/dynamic_height_table.dart.dart';
import 'package:flutter/material.dart';

import 'models/table_cell_data.dart';

import 'models/table_row_data.dart';

class DynamicTableRow {
  final TableRowData rowData;
  final TextStyle cellTextStyle;
  final Color cellColor;
  final int numColumns;
  final bool wrapContent;
  final CellContentBuilder? cellContentBuilder;
  final DeleteRowCallback? onDeleteRow;
  final int rowIndex;

  DynamicTableRow({
    required this.rowData,
    required this.cellTextStyle,
    required this.cellColor,
    required this.numColumns,
    this.wrapContent = false,
    this.cellContentBuilder,
    this.onDeleteRow,
    required this.rowIndex,
  });

  TableRow buildTableRow() {
    List<TableCellData> rowCells = List.from(rowData.cells);
    // Agregar celdas vacías si es necesario
    while (rowCells.length < numColumns) {
      rowCells.add(TableCellData(content: '', isEditable: false));
    }
    return TableRow(
      decoration: BoxDecoration(color: cellColor),
      children: rowCells.asMap().entries.map((entry) {
        int cellIndex = entry.key;
        TableCellData cellData = entry.value;
        return TableCell(
          child: Stack(
            children: [
              IntrinsicHeight(
                child: cellContentBuilder != null
                    ? cellContentBuilder!(rowIndex, cellIndex, cellData)
                    : DynamicTableCell(
                        cellData: cellData,
                        cellTextStyle: cellTextStyle,
                        onCellUpdate: null,
                        wrapContent: wrapContent,
                      ),
              ),
              if (onDeleteRow != null && cellIndex == rowCells.length - 1)
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      onDeleteRow!(rowIndex);
                    },
                  ),
                ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
