class AnilistUser {
  int anilistUserId;
  String anilistUserName;
  String anilistUserAvatarLarge;
  String anilistUserAvatarMedium;

  AnilistUser({
    required this.anilistUserId,
    required this.anilistUserName,
    required this.anilistUserAvatarLarge,
    required this.anilistUserAvatarMedium
  });

  factory AnilistUser.fromJson(Map<String, dynamic> json) {
    return AnilistUser(
      anilistUserId: json['id'] as int? ?? 0,
      anilistUserName: json['name'] as String? ?? "",
      anilistUserAvatarLarge: json['avatar']['large'] as String? ?? "",
      anilistUserAvatarMedium: json['avatar']['medium'] as String? ?? "",
    );
  }

  AnilistUser getAnilistUser() {
    return this;
  }

  int getAnilistUserId() {
    return anilistUserId;
  }

  String getAnilistUserName() {
    return anilistUserName;
  }

  String getAnilistUserAvatarLarge() {
    return anilistUserAvatarLarge;
  }

  String getAnilistUserAvatarMedium() {
    return anilistUserAvatarMedium;
  }
}