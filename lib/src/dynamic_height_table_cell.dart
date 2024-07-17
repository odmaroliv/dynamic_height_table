import 'package:flutter/material.dart';

class DynamicHeightTableCell extends StatelessWidget {
  final String cellId;
  final dynamic cell;
  final TextStyle? cellStyle;
  final Set<String> readOnlyCells;
  final bool isEditable;
  final Function(int, int)? onCellTap;
  final Function(int, int)? onCellHover;
  final Function(String) onEditingCell;
  final String? editingCellId;

  DynamicHeightTableCell({
    required this.cellId,
    required this.cell,
    this.cellStyle,
    required this.readOnlyCells,
    required this.isEditable,
    this.onCellTap,
    this.onCellHover,
    required this.onEditingCell,
    this.editingCellId,
  });

  @override
  Widget build(BuildContext context) {
    bool readOnly = readOnlyCells.contains(cellId);
    return GestureDetector(
      onTap: () {
        if (isEditable && !readOnly) {
          onEditingCell(cellId);
        }
        if (onCellTap != null) {
          List<String> indices = cellId.split('-');
          onCellTap!(int.parse(indices[0]), int.parse(indices[1]));
        }
      },
      child: MouseRegion(
        onEnter: (event) {
          if (onCellHover != null) {
            List<String> indices = cellId.split('-');
            onCellHover!(int.parse(indices[0]), int.parse(indices[1]));
          }
        },
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: _buildCellContent(context),
        ),
      ),
    );
  }

  Widget _buildCellContent(BuildContext context) {
    if (editingCellId == cellId && isEditable && cell is String) {
      return TextFormField(
        initialValue: cell,
        style: cellStyle,
        maxLines: null,
        decoration: InputDecoration(
          border: InputBorder.none,
        ),
        onFieldSubmitted: (value) {
          List<String> indices = cellId.split('-');
          // Implementa la lógica para actualizar el valor de la celda en _data
          // Utiliza el setState del contenedor para actualizar la celda
        },
      );
    } else if (cell is Widget) {
      return cell;
    } else {
      return Text(
        cell.toString(),
        style: cellStyle ?? TextStyle(color: Colors.black87),
        softWrap: true,
        maxLines: null,
        overflow: TextOverflow.visible,
      );
    }
  }
}
