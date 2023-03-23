// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Vector2 extends Equatable {
  final double x;
  final double y;
  const Vector2(this.x, this.y);

  @override
  List<Object> get props => [x, y];
}
