
import 'package:flutter/material.dart';

final _icons = <String, IconData> {
  'add_alert'   : Icons.add_alert,
  'accessibility': Icons.accessibility,
  'folder_open' : Icons.folder_open,
  'donut_large': Icons.donut_large,
  'input': Icons.input,
  'swap_horizontal_circle': Icons.swap_horizontal_circle,
  'list': Icons.list,
};

Icon getIcon (String nombre , Color color) {

  return Icon(_icons[nombre], color: color);
}