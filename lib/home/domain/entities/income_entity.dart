// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class IncomeEntity extends Equatable {
  final String name;
  final double income;

  const IncomeEntity({required this.name, required this.income});

  @override
  List<Object> get props => [name, income];
}
