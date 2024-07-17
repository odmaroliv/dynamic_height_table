import 'package:flutter/material.dart';
import 'dynamic_height_table_cell.dart';

class DynamicHeightTableRow extends StatelessWidget {
  final int rowIndex;
  final List<dynamic> row;
  final TextStyle? cellStyle;
  final Color? rowColor;
  final Color? hoverColor;
  final Set<String> readOnlyCells;
  final bool isEditable;
  final Function(int, int)? onCellTap;
  final Function(int, int)? onCellHover;
  final Function(int)? onRowHover;
  final Function(String) onEditingCell;
  final String? editingCellId;
  final List<Widget> Function(int)? additionalActions;

  DynamicHeightTableRow({
    required this.rowIndex,
    required this.row,
    this.cellStyle,
    this.rowColor,
    this.hoverColor,
    required this.readOnlyCells,
    required this.isEditable,
    this.onCellTap,
    this.onCellHover,
    this.onRowHover,
    required this.onEditingCell,
    this.editingCellId,
    this.additionalActions,
  });

  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        buildRow(
            context, null, onRowHover ?? (_) {}, editingCellId, onEditingCell)
      ],
    );
  }

  TableRow buildRow(
      BuildContext context,
      int? hoveredRowIndex,
      Function(int) onRowHover,
      String? editingCellId,
      Function(String) onEditingCell) {
    return TableRow(
      decoration: BoxDecoration(
        color: hoveredRowIndex == rowIndex
            ? (hoverColor ?? Colors.grey[200])
            : rowColor ?? Colors.white,
      ),
      children: row.map((cell) {
        int cellIndex = row.indexOf(cell);
        String cellId =
            "$rowIndex-$cellIndex"; // Unique identifier for each cell
        return TableCell(
          child: MouseRegion(
            onEnter: (_) => onRowHover(rowIndex),
            child: DynamicHeightTableCell(
              cellId: cellId,
              cell: cell,
              cellStyle: cellStyle,
              readOnlyCells: readOnlyCells,
              isEditable: isEditable,
              onCellTap: onCellTap,
              onCellHover: onCellHover,
              onEditingCell: onEditingCell,
              editingCellId: editingCellId,
            ),
          ),
        );
      }).toList()
        ..add(_buildActionButtons(context, rowIndex)),
    );
  }

  TableCell _buildActionButtons(BuildContext context, int index) {
    return TableCell(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: additionalActions != null ? additionalActions!(index) : [],
      ),
    );
  }
}
