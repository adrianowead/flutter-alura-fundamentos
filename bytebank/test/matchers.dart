import 'package:bytebank/screens/home/ItemDashboard.dart';
import 'package:flutter/material.dart';

bool itemDashboardMatcher(Widget widget, String name, IconData icon) {
  if (widget is ItemDashboard) {
    return widget.nome == name && widget.icone == icon;
  }

  return false;
}
