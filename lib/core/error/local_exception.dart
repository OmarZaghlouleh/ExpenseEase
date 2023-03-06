// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:budgeting_app/core/error/error_model.dart';

class LocalException implements Exception {
  final ErrorModel errorModel;
  LocalException({
    required this.errorModel,
  });
}
