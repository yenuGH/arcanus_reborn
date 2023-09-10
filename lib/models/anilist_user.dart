class AnilistUser {
  int anilistUserId;
  String anilistUserName;
  String anilistUserAvatarLarge;
  String anilistUserAvatarMedium;
  String anilistUserBannerImage;

  AnilistUser({
    required this.anilistUserId,
    required this.anilistUserName,
    required this.anilistUserAvatarLarge,
    required this.anilistUserAvatarMedium,
    required this.anilistUserBannerImage,
  });

  factory AnilistUser.fromJson(Map<String, dynamic> json) {
    return AnilistUser(
      anilistUserId: json['id'] as int? ?? 0,
      anilistUserName: json['name'] as String? ?? "",
      anilistUserAvatarLarge: json['avatar']['large'] as String? ?? "",
      anilistUserAvatarMedium: json['avatar']['medium'] as String? ?? "",
      anilistUserBannerImage: json['bannerImage'] as String? ?? "",
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

  String getAnilistUserBannerImage() {
    return anilistUserBannerImage;
  }
}