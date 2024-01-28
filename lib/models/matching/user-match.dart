import 'package:equatable/equatable.dart';
import 'package:honey_mobile/models/chat/chat.dart';
import 'package:honey_mobile/models/user/users.dart';

class UserMatch extends Equatable {
  final int id;
  final int userId;
  final User matchedUser;

  final List<Chat>? chat;

  const UserMatch({
    required this.id,
    required this.userId,
    required this.matchedUser,
    required this.chat,
  });

  @override
  List<Object?> get props => [id, userId, matchedUser];
}
