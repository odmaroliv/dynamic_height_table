import 'package:flutter/material.dart';
import 'dart:convert';
import 'dynamic_height_table_header.dart';
import 'dynamic_height_table_row.dart';

class DynamicHeightTableContainer extends StatefulWidget {
  final List<Widget> children;
  final Color? borderColor;
  final List<TableColumnWidth>? columnWidths;

  DynamicHeightTableContainer({
    Key? key,
    required this.children,
    this.borderColor,
    this.columnWidths,
  }) : super(key: key);

  @override
  DynamicHeightTableContainerState createState() =>
      DynamicHeightTableContainerState();
}

class DynamicHeightTableContainerState
    extends State<DynamicHeightTableContainer> {
  int? _hoveredRowIndex;
  String? _editingCellId;
  List<List<dynamic>> _data = [];
  Set<String> _readOnlyCells = {};

  @override
  void initState() {
    super.initState();
    _data = widget.children
        .whereType<DynamicHeightTableRow>()
        .map((row) => row.row)
        .toList();
    widget.children.whereType<DynamicHeightTableRow>().forEach((row) {
      row.readOnlyCells.forEach((cellId) {
        _readOnlyCells.add(cellId);
      });
    });
  }

  void addRow(List<dynamic> rowData, {Set<int>? readOnlyColumns}) {
    setState(() {
      int newRowIdx = _data.length;
      _data.add(rowData);
      if (readOnlyColumns != null) {
        readOnlyColumns.forEach((colIdx) {
          _readOnlyCells.add("$newRowIdx-$colIdx");
        });
      }
    });
  }

  String exportToJson() {
    return _toJson(_data);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Table(
        columnWidths: widget.columnWidths != null
            ? Map.fromIterables(
                List.generate(widget.columnWidths!.length, (index) => index),
                widget.columnWidths!,
              )
            : {0: FlexColumnWidth()},
        border: TableBorder.symmetric(
          inside: BorderSide(color: widget.borderColor ?? Colors.grey.shade300),
        ),
        children: widget.children.map((child) {
          if (child is DynamicHeightTableRow) {
            return child.buildRow(context, _hoveredRowIndex, _onRowHover,
                _editingCellId, _onEditingCell);
          } else if (child is DynamicHeightTableHeader) {
            return child.buildHeaderRow(context);
          }
          return TableRow(children: [child]);
        }).toList(),
      ),
    );
  }

  void _onEditingCell(String cellId) {
    setState(() {
      _editingCellId = cellId;
    });
  }

  void _onRowHover(int rowIndex) {
    setState(() {
      _hoveredRowIndex = rowIndex;
    });
  }

  String _toJson(List<List<dynamic>> data) {
    List<List<dynamic>> sanitizedData = data.map((row) {
      return row.map((cell) {
        if (cell is Icon) {
          return cell.icon.toString();
        } else if (cell is Widget) {
          return 'Widget';
        }
        return cell.toString();
      }).toList();
    }).toList();
    return json.encode(sanitizedData);
  }
}
