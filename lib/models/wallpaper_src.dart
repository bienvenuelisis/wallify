import 'package:json_annotation/json_annotation.dart';

part 'wallpaper_src.g.dart';

@JsonSerializable()
class WallpaperSrc {
  final String original;
  final String tiny;
  final String large;
  final String large2x;
  final String medium;
  final String small;
  final String portrait;
  final String landscape;

  WallpaperSrc(
    this.original,
    this.tiny,
    this.landscape,
    this.portrait,
    this.large,
    this.large2x,
    this.medium,
    this.small,
  );

  factory WallpaperSrc.fromJson(Map<String, dynamic> json) =>
      _$WallpaperSrcFromJson(json);

  Map<String, dynamic> toJson() => _$WallpaperSrcToJson(this);
}
