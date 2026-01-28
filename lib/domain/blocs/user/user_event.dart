import 'package:bill_share/domain/models/user_create_dto.dart';
import 'package:equatable/equatable.dart';

class UserEvent extends Equatable {
  const UserEvent();
  @override
  List<Object?> get props => [];
}

class UserInfoCreate extends UserEvent {
  final UserCreateDto payload;

  const UserInfoCreate({required this.payload});

  @override
  List<Object?> get props => [payload];
}
