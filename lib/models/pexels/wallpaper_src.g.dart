// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallpaper_src.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WallPaperSrc _$WallPaperSrcFromJson(Map<String, dynamic> json) => WallPaperSrc(
      json['original'] as String,
      json['tiny'] as String,
      json['landscape'] as String,
      json['portrait'] as String,
      json['large'] as String,
      json['large2x'] as String,
      json['medium'] as String,
      json['small'] as String,
    );

Map<String, dynamic> _$WallPaperSrcToJson(WallPaperSrc instance) =>
    <String, dynamic>{
      'original': instance.original,
      'tiny': instance.tiny,
      'large': instance.large,
      'large2x': instance.large2x,
      'medium': instance.medium,
      'small': instance.small,
      'portrait': instance.portrait,
      'landscape': instance.landscape,
    };