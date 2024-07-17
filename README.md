<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

# Dynamic Height Table

Dynamic Height Table for Flutter allows you to create dynamic tables that automatically adjust to the height of the content. It provides a flexible and customizable way to display tabular data, supporting editable cells, custom widgets within cells, and adaptive visual styling.

This is an open-source project that is not yet finished. It is simply a package that I update in my spare time, arising from the difficulty of managing dynamic height according to the content in the DataTable provided by Flutter.

## Features

- Automatically adjusts the height of cells based on their content
- Editable cells
- Custom widgets within cells
- Customizable table styling

![Captura de pantalla 2024-07-17 132527](https://github.com/user-attachments/assets/89021b63-fb49-4577-821c-d5f6cfc02f87)
![Captura de pantalla 2024-07-17 132452](https://github.com/user-attachments/assets/010e2e79-84b2-4a1c-89b6-a9fea06ec03e)
![Captura de pantalla 2024-07-17 133906](https://github.com/user-attachments/assets/a3881ef6-b91e-4078-b0cf-2f5531f6e7ba)



## Getting started

Add the following dependency to your `pubspec.yaml` file:
```
yaml
dependencies:
  dynamic_height_table:
    git:
      url: https://github.com/odmaroliv/dynamic_height_table.git
      ref: main
```

## Usage
```
Import the library:
import 'package:dynamic_height_table/dynamic_height_table.dart';
import 'package:flutter/material.dart';
```
## Basic Example

Create a Dynamic Table:
```
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<TableRowData> tableData = [
      TableRowData(
        id: 0,
        cells: [
          TableCellData(content: 'Row 1, Cell 1', isEditable: true),
          TableCellData(content: 'Row 1, Cell 2', isEditable: true),
          TableCellData(content: 'Row 1, Cell 3', isEditable: true),
        ],
      ),
      TableRowData(
        id: 1,
        cells: [
          TableCellData(content: 'Row 2, Cell 1', isEditable: true),
          TableCellData(content: 'Row 2, Cell 2', isEditable: true),
          TableCellData(content: 'Row 2, Cell 3', isEditable: true),
        ],
      ),
    ];

    List<String> headers = ['Header 1', 'Header 2', 'Header 3'];

    return Scaffold(
      appBar: AppBar(
        title: Text("Dynamic Height Table Example"),
      ),
      body: Center(
        child: DynamicTable(
          data: tableData,
          headers: headers,
          headerColor: Colors.blueGrey,
          cellColor: Colors.white,
          headerTextStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          cellTextStyle: TextStyle(color: Colors.black),
          elevation: 4.0,
          wrapContent: true,
        ),
      ),
    );
  }
}
```

## Parameters

DynamicTable
data: List<TableRowData> - Data for the table, where each item represents a row.
headers: List<String> - Headers for the table.
headerColor: Color - Background color for the headers.
cellColor: Color - Background color for the cells.
headerTextStyle: TextStyle - Text style for the headers.
cellTextStyle: TextStyle - Text style for the cells.
elevation: double - Elevation of the table.
wrapContent: bool - Whether the cells should adjust their height to the content.
cellContentBuilder: CellContentBuilder - Function to build custom content in the cells.

TableCellData
content: String - Content of the cell.
isEditable: bool - Whether the cell is editable.
customWidget: Widget? - Custom widget for the cell.

## Advanced Examples

Using Custom Widgets in Cells


```
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<TableRowData> tableData = [
      TableRowData(
        id: 0,
        cells: [
          TableCellData(content: 'Row 1, Cell 1', isEditable: true),
          TableCellData(content: 'Row 1, Cell 2', isEditable: true),
          TableCellData(
            content: 'Row 1, Cell 3',
            customWidget: IconButton(
              icon: Icon(Icons.print),
              onPressed: () {
                print('Row 1, Cell 3 button pressed');
              },
            ),
          ),
        ],
      ),
      TableRowData(
        id: 1,
        cells: [
          TableCellData(content: 'Row 2, Cell 1', isEditable: true),
          TableCellData(content: 'Row 2, Cell 2', isEditable: true),
          TableCellData(content: 'Row 2, Cell 3', isEditable: true),
        ],
      ),
    ];

    List<String> headers = ['Header 1', 'Header 2', 'Header 3'];

    return Scaffold(
      appBar: AppBar(
        title: Text("Dynamic Height Table Example"),
      ),
      body: Center(
        child: DynamicTable(
          data: tableData,
          headers: headers,
          headerColor: Colors.blueGrey,
          cellColor: Colors.white,
          headerTextStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          cellTextStyle: TextStyle(color: Colors.black),
          elevation: 4.0,
          wrapContent: true,
        ),
      ),
    );
  }
}
```

Programmatic Cell Content Generation
```
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<TableRowData> tableData = [
      TableRowData(
        id: 0,
        cells: [
          TableCellData(content: 'Row 1, Cell 1', isEditable: true),
          TableCellData(content: 'Row 1, Cell 2', isEditable: true),
          TableCellData(content: 'Row 1, Cell 3', isEditable: true),
        ],
      ),
      TableRowData(
        id: 1,
        cells: [
          TableCellData(content: 'Row 2, Cell 1', isEditable: true),
          TableCellData(content: 'Row 2, Cell 2', isEditable: true),
          TableCellData(content: 'Row 2, Cell 3', isEditable: true),
        ],
      ),
    ];

    List<String> headers = ['Header 1', 'Header 2', 'Header 3'];

    return Scaffold(
      appBar: AppBar(
        title: Text("Dynamic Height Table Example"),
      ),
      body: Center(
        child: DynamicTable(
          data: tableData,
          headers: headers,
          headerColor: Colors.blueGrey,
          cellColor: Colors.white,
          headerTextStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          cellTextStyle: TextStyle(color: Colors.black),
          elevation: 4.0,
          wrapContent: true,
          cellContentBuilder: (rowIndex, columnIndex, cellData) {
            if (columnIndex == 2) {
              return IconButton(
                icon: Icon(Icons.info),
                onPressed: () {
                  print('Row $rowIndex, Column $columnIndex button pressed');
                },
              );
            }
            return DynamicTableCell(
              cellData: cellData,
              cellTextStyle: TextStyle(color: Colors.black),
              wrapContent: true,
            );
          },
        ),
      ),
    );
  }
}
```

## Customization
You can customize almost any aspect of the table using the provided parameters and the ability to build custom cell content.

Style Customization Example:
```
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<TableRowData> tableData = [
      TableRowData(
        id: 0,
        cells: [
          TableCellData(content: 'Row 1, Cell 1', isEditable: true),
          TableCellData(content: 'Row 1, Cell 2', isEditable: true),
          TableCellData(content: 'Row 1, Cell 3', isEditable: true),
        ],
      ),
      TableRowData(
        id: 1,
        cells: [
          TableCellData(content: 'Row 2, Cell 1', isEditable: true),
          TableCellData(content: 'Row 2, Cell 2', isEditable: true),
          TableCellData(content: 'Row 2, Cell 3', isEditable: true),
        ],
      ),
    ];

    List<String> headers = ['Header 1', 'Header 2', 'Header 3'];

    return Scaffold(
      appBar: AppBar(
        title: Text("Dynamic Height Table Example"),
      ),
      body: Center(
        child: DynamicTable(
          data: tableData,
          headers: headers,
          headerColor: Colors.deepPurple,
          cellColor: Colors.purpleAccent,
          headerTextStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          cellTextStyle: TextStyle(color: Colors.black),
          elevation: 8.0,
          wrapContent: true,
        ),
      ),
    );
  }
}
```

## Contributions

If you encounter any issues or have suggestions for improving this library, please open an issue or a pull request on our GitHub repository.

## License
This library is licensed under the MIT License. For more details, see the LICENSE file in the repository.
