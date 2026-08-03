// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'story_progress.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StoryProgress _$StoryProgressFromJson(Map<String, dynamic> json) {
  return _StoryProgress.fromJson(json);
}

/// @nodoc
mixin _$StoryProgress {
  /// Unique story identifier
  String get storyId => throw _privateConstructorUsedError;

  /// Current page index (0-based)
  int get currentPage => throw _privateConstructorUsedError;

  /// Whether the story has been fully read
  bool get isCompleted => throw _privateConstructorUsedError;

  /// Last time the story was read
  DateTime? get lastRead => throw _privateConstructorUsedError;

  /// Serializes this StoryProgress to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StoryProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StoryProgressCopyWith<StoryProgress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoryProgressCopyWith<$Res> {
  factory $StoryProgressCopyWith(
          StoryProgress value, $Res Function(StoryProgress) then) =
      _$StoryProgressCopyWithImpl<$Res, StoryProgress>;
  @useResult
  $Res call(
      {String storyId, int currentPage, bool isCompleted, DateTime? lastRead});
}

/// @nodoc
class _$StoryProgressCopyWithImpl<$Res, $Val extends StoryProgress>
    implements $StoryProgressCopyWith<$Res> {
  _$StoryProgressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StoryProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? storyId = null,
    Object? currentPage = null,
    Object? isCompleted = null,
    Object? lastRead = freezed,
  }) {
    return _then(_value.copyWith(
      storyId: null == storyId
          ? _value.storyId
          : storyId // ignore: cast_nullable_to_non_nullable
              as String,
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      lastRead: freezed == lastRead
          ? _value.lastRead
          : lastRead // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StoryProgressImplCopyWith<$Res>
    implements $StoryProgressCopyWith<$Res> {
  factory _$$StoryProgressImplCopyWith(
          _$StoryProgressImpl value, $Res Function(_$StoryProgressImpl) then) =
      __$$StoryProgressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String storyId, int currentPage, bool isCompleted, DateTime? lastRead});
}

/// @nodoc
class __$$StoryProgressImplCopyWithImpl<$Res>
    extends _$StoryProgressCopyWithImpl<$Res, _$StoryProgressImpl>
    implements _$$StoryProgressImplCopyWith<$Res> {
  __$$StoryProgressImplCopyWithImpl(
      _$StoryProgressImpl _value, $Res Function(_$StoryProgressImpl) _then)
      : super(_value, _then);

  /// Create a copy of StoryProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? storyId = null,
    Object? currentPage = null,
    Object? isCompleted = null,
    Object? lastRead = freezed,
  }) {
    return _then(_$StoryProgressImpl(
      storyId: null == storyId
          ? _value.storyId
          : storyId // ignore: cast_nullable_to_non_nullable
              as String,
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      lastRead: freezed == lastRead
          ? _value.lastRead
          : lastRead // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StoryProgressImpl implements _StoryProgress {
  const _$StoryProgressImpl(
      {required this.storyId,
      this.currentPage = 0,
      this.isCompleted = false,
      this.lastRead});

  factory _$StoryProgressImpl.fromJson(Map<String, dynamic> json) =>
      _$$StoryProgressImplFromJson(json);

  /// Unique story identifier
  @override
  final String storyId;

  /// Current page index (0-based)
  @override
  @JsonKey()
  final int currentPage;

  /// Whether the story has been fully read
  @override
  @JsonKey()
  final bool isCompleted;

  /// Last time the story was read
  @override
  final DateTime? lastRead;

  @override
  String toString() {
    return 'StoryProgress(storyId: $storyId, currentPage: $currentPage, isCompleted: $isCompleted, lastRead: $lastRead)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoryProgressImpl &&
            (identical(other.storyId, storyId) || other.storyId == storyId) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.lastRead, lastRead) ||
                other.lastRead == lastRead));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, storyId, currentPage, isCompleted, lastRead);

  /// Create a copy of StoryProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StoryProgressImplCopyWith<_$StoryProgressImpl> get copyWith =>
      __$$StoryProgressImplCopyWithImpl<_$StoryProgressImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StoryProgressImplToJson(
      this,
    );
  }
}

abstract class _StoryProgress implements StoryProgress {
  const factory _StoryProgress(
      {required final String storyId,
      final int currentPage,
      final bool isCompleted,
      final DateTime? lastRead}) = _$StoryProgressImpl;

  factory _StoryProgress.fromJson(Map<String, dynamic> json) =
      _$StoryProgressImpl.fromJson;

  /// Unique story identifier
  @override
  String get storyId;

  /// Current page index (0-based)
  @override
  int get currentPage;

  /// Whether the story has been fully read
  @override
  bool get isCompleted;

  /// Last time the story was read
  @override
  DateTime? get lastRead;

  /// Create a copy of StoryProgress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StoryProgressImplCopyWith<_$StoryProgressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
