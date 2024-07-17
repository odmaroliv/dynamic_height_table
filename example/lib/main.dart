import 'package:dynamic_height_table/dynamic_height_table.dart.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dynamic Height Table Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<List<dynamic>> testData = [
    ["Apple", "A fruit that is sweet and crunchy.", "10"],
    [
      "Elderberry",
      """Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt
      ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation 
      ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non \
      proident, sunt in culpa qui officia deserunt mollit anim id est laborum.""",
      "12"
    ],
    ["Elderberry", "A small, dark purple fruit used in jams and syrups.", "12"],
    [Icon(Icons.star), "This cell contains an icon", "N/A"],
  ];

  final GlobalKey<DynamicHeightTableContainerState> _tableKey =
      GlobalKey<DynamicHeightTableContainerState>();

  void _editRow(int index) {
    // Edit row logic here
    print('Edit row $index');
  }

  void _deleteRow(int index) {
    setState(() {
      testData.removeAt(index);
    });
  }

  void _onCellTap(int rowIndex, int cellIndex) {
    print('Cell tapped at row $rowIndex, column $cellIndex');
  }

  void _onCellHover(int rowIndex, int cellIndex) {
    print('Cell hovered at row $rowIndex, column $cellIndex');
  }

  List<Widget> _additionalActions(int index) {
    return [
      IconButton(
        icon: Icon(Icons.info, color: Colors.green),
        onPressed: () {
          // Additional action logic
          print('Info action on row $index');
        },
      ),
      IconButton(
        icon: Icon(Icons.edit, color: Colors.blue),
        onPressed: () {
          setState(() {
            _editRow(index);
          });
        },
      ),
      IconButton(
        icon: Icon(Icons.delete, color: Colors.red),
        onPressed: () {
          setState(() {
            _deleteRow(index);
          });
        },
      ),
    ];
  }

  void _addRow() {
    List<dynamic> newRow = ["", "", ""];
    Set<int> readOnlyColumns = {
      1
    }; // Ejemplo: La segunda columna será de solo lectura
    _tableKey.currentState?.addRow(newRow, readOnlyColumns: readOnlyColumns);
  }

  void _exportData() {
    String jsonData = _tableKey.currentState?.exportToJson() ?? '';
    print(jsonData); // Print the JSON data to the console
  }

  @override
  Widget build(BuildContext context) {
    final columnHeaders = ["Name", "Description", "Quantity"];

    return Scaffold(
      appBar: AppBar(
        title: Text('Dynamic Height Table Example'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addRow,
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: _exportData,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DynamicHeightTableContainer(
          key: _tableKey,
          borderColor: Colors.grey.shade300,
          columnWidths: [
            FlexColumnWidth(1),
            FlexColumnWidth(3),
            FlexColumnWidth(1),
            IntrinsicColumnWidth()
          ],
          children: [
            DynamicHeightTableHeader(
              columnHeaders: columnHeaders,
              headerStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              headerColor: Colors.grey[300],
              additionalActions: true,
            ),
            ...testData.asMap().entries.map((entry) {
              int rowIndex = entry.key;
              List<dynamic> row = entry.value;
              return DynamicHeightTableRow(
                rowIndex: rowIndex,
                row: row,
                cellStyle: TextStyle(fontSize: 14),
                rowColor: Colors.white,
                readOnlyCells: {"$rowIndex-2"}, // Example of read-only cells
                isEditable: true,
                onCellTap: _onCellTap,
                onCellHover: _onCellHover,
                onRowHover: (index) {
                  print('Row hovered: $index');
                },
                onEditingCell: (cellId) {
                  setState(() {
                    // Handle editing state if necessary
                  });
                },
                editingCellId: null,
                additionalActions: _additionalActions,
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
