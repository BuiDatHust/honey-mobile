import 'package:honey_mobile/models/user/account-setting.dart';
import 'package:honey_mobile/models/user/media.dart';
import 'package:honey_mobile/models/user/notification-setting.dart';
import 'package:honey_mobile/models/user/search-setting.dart';
import 'package:honey_mobile/models/user/show-media.dart';
import 'package:json_annotation/json_annotation.dart';

part 'users.g.dart';

@JsonSerializable()
class User {
  @JsonKey(required: true, name: "_id")
  String id;

  @JsonKey(required: false)
  String? firstname;

  @JsonKey(required: true)
  String phone_number;

  @JsonKey(required: false)
  String? email;

  @JsonKey(required: false)
  List<Media?>? medias;

  @JsonKey(required: false)
  List<ShowMedia?>? show_medias;

  @JsonKey(required: false)
  String? gender;

  @JsonKey(required: false)
  String? gender_show;

  @JsonKey(required: false)
  int? dob;

  @JsonKey(required: false)
  int? age;

  @JsonKey(required: false)
  int? height;

  @JsonKey(required: false)
  String? sexual_orientation;

  @JsonKey(required: false)
  String? relationship_goal;

  @JsonKey(required: false)
  String? description;

  @JsonKey(required: false)
  String country_code;

  @JsonKey(required: false)
  List<String>? passions;

  @JsonKey(required: false)
  String? company;

  @JsonKey(required: false)
  String? job_title;

  @JsonKey(required: false)
  String? address;

  @JsonKey(required: false)
  List<String>? languages;

  @JsonKey(required: false)
  List<double>? coordinates;

  @JsonKey(required: false)
  List<String>? visualization_fields;

  @JsonKey(required: false)
  int? completation_percentage;

  @JsonKey(required: false)
  bool? is_verified;

  @JsonKey(required: true)
  String status;

  @JsonKey(required: false)
  int? banned_at;

  @JsonKey(required: false)
  int? unban_at;

  @JsonKey(required: false)
  bool? is_verified_phone;

  @JsonKey(required: false)
  bool? is_verified_email;

  @JsonKey(required: false)
  AccountSetting? account_setting;

  @JsonKey(required: false)
  NotificationSetting? notification_setting;

  @JsonKey(required: false)
  SearchSetting? search_setting;

  @JsonKey(required: true)
  int created_at;

  @JsonKey(required: false)
  int? updated_at;

  @JsonKey(required: false)
  int? deleted_at;

  User({
    required this.phone_number,
    required this.country_code,
    required this.status,
    required this.id,
    required this.created_at,
    this.show_medias,
    this.firstname,
    this.email,
    this.medias,
    this.gender,
    this.gender_show,
    this.dob,
    this.age,
    this.height,
    this.sexual_orientation,
    this.relationship_goal,
    this.description,
    this.passions,
    this.company,
    this.job_title,
    this.address,
    this.languages,
    this.coordinates,
    this.visualization_fields,
    this.completation_percentage,
    this.is_verified,
    this.banned_at,
    this.unban_at,
    this.is_verified_phone,
    this.is_verified_email,
    this.updated_at,
    this.deleted_at,
  });
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  static User fromJsonT(Object? json) {
    if (json == null) {
      return User(
          phone_number: "",
          country_code: "84",
          status: "",
          id: "",
          created_at: 1);
    }

    return _$UserFromJson(json as Map<String, dynamic>);
  }
}
