// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ErrorModel extends Equatable {
  final String message;
  const ErrorModel({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
