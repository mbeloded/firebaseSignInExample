
import 'package:flutter/widgets.dart';

@immutable
abstract class NavEvent {
  final List args;

  NavEvent([this.args = const []]);
}

class NavPopCurrentScreen extends NavEvent {
  @override
  List<Object> get props => null;
}

class NavHome extends NavEvent {

  NavHome([args]) : super(args);

  @override
  List<Object> get props => [args];
}