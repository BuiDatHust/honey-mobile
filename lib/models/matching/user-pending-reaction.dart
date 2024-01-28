import 'package:honey_mobile/models/user/show-media.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user-pending-reaction.g.dart';

@JsonSerializable()
class UserPendingReaction {
  @JsonKey(required: true, name: "_id")
  String id;

  @JsonKey(required: true)
  String firstname;

  @JsonKey(required: true)
  List<ShowMedia> show_medias;

  UserPendingReaction({
    required this.id,
    required this.firstname,
    required this.show_medias,
  });

  factory UserPendingReaction.fromJson(Map<String, dynamic> json) =>
      _$UserPendingReactionFromJson(json);
  Map<String, dynamic> toJson() => _$UserPendingReactionToJson(this);
}
