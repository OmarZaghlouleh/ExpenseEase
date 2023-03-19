// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Percent extends Equatable {
  final double decimal;
  final int percentage;

  const Percent({required this.decimal, required this.percentage});

  factory Percent.empty() {
    return const Percent(decimal: 0, percentage: 0);
  }

  @override
  List<Object> get props => [decimal, percentage];
}
