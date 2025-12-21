import 'package:bill_share/constants/enums.dart';
import 'package:equatable/equatable.dart';

abstract class BaseState extends Equatable {
  final RequestStatus status;
  final String? error;
  const BaseState({required this.status, this.error});
}
