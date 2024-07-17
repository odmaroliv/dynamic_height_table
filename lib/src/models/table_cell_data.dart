import 'package:flutter/material.dart';

class TableCellData {
  String content;
  bool isEditable;
  Widget? customWidget;

  TableCellData({
    required this.content,
    this.isEditable = true,
    this.customWidget,
  });

  void updateContent(String newContent) {
    if (isEditable) {
      content = newContent;
    }
  }
}
