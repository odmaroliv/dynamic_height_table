import 'package:dynamic_height_table/dynamic_height_table.dart.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _rowIdCounter = 2;
  List<TableRowData> tableData = [
    TableRowData(
      id: 0,
      cells: [
        TableCellData(content: 'Row 1, Cell 1', isEditable: false),
        TableCellData(content: 'Row 1, Cell 2', isEditable: true),
        TableCellData(content: 'Row 1, Cell 3', isEditable: true),
      ],
    ),
    TableRowData(
      id: 1,
      cells: [
        TableCellData(
          content:
              'Row 2, Cell 1 with very long content that needs wrapping to be fully visible',
          isEditable: true,
        ),
        TableCellData(content: 'Row 2, Cell 2', isEditable: false),
        TableCellData(content: 'Row 2, Cell 3'),
        TableCellData(
          content: 'Row 2, Cell 4',
          customWidget: Row(
            children: [
              IconButton(
                icon: Icon(Icons.kayaking_sharp),
                onPressed: () {
                  print('Row 2, Cell 3 button pressed');
                },
              ),
              IconButton(
                icon: Icon(Icons.kayaking_sharp),
                onPressed: () {
                  print('Row 2, Cell 3 button pressed');
                },
              ),
            ],
          ),
        ),
      ],
    ),
  ];

  void _addNewRow() {
    setState(() {
      _rowIdCounter++;
      tableData.add(
        TableRowData(
          id: _rowIdCounter,
          cells: List.generate(
            4,
            (index) => TableCellData(content: 'New Row, Cell ${index + 1}'),
          ),
        ),
      );
    });
  }

  void _deleteRow(int rowIndex) {
    setState(() {
      tableData.removeAt(rowIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dynamic Height Table Example"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addNewRow,
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: DynamicTable(
                data: tableData,
                headers: ['Columna 1', 'Columna 2', 'Columna 3', 'Columna 4'],
                headerColor: Color.fromARGB(185, 18, 6, 129),
                cellColor: Color.fromARGB(221, 234, 234, 237),
                headerTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 255, 255, 255)),
                cellTextStyle: TextStyle(color: Colors.black87),
                elevation: 10.0,
                wrapContent: false,
                onAddRow: _addNewRow,
                onDeleteRow: _deleteRow,
                cellContentBuilder: (rowIndex, columnIndex, cellData) {
                  return DynamicTableCell(
                    cellData: cellData,
                    cellTextStyle: TextStyle(color: Colors.black87),
                    wrapContent: false,
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
