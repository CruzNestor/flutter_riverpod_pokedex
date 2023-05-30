// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'generation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Generation _$GenerationFromJson(Map<String, dynamic> json) {
  return _Generation.fromJson(json);
}

/// @nodoc
mixin _$Generation {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'pokemon_species')
  List<dynamic> get pokemonSpecies => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GenerationCopyWith<Generation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GenerationCopyWith<$Res> {
  factory $GenerationCopyWith(
          Generation value, $Res Function(Generation) then) =
      _$GenerationCopyWithImpl<$Res, Generation>;
  @useResult
  $Res call(
      {int id,
      String name,
      @JsonKey(name: 'pokemon_species') List<dynamic> pokemonSpecies});
}

/// @nodoc
class _$GenerationCopyWithImpl<$Res, $Val extends Generation>
    implements $GenerationCopyWith<$Res> {
  _$GenerationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? pokemonSpecies = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      pokemonSpecies: null == pokemonSpecies
          ? _value.pokemonSpecies
          : pokemonSpecies // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GenerationCopyWith<$Res>
    implements $GenerationCopyWith<$Res> {
  factory _$$_GenerationCopyWith(
          _$_Generation value, $Res Function(_$_Generation) then) =
      __$$_GenerationCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      @JsonKey(name: 'pokemon_species') List<dynamic> pokemonSpecies});
}

/// @nodoc
class __$$_GenerationCopyWithImpl<$Res>
    extends _$GenerationCopyWithImpl<$Res, _$_Generation>
    implements _$$_GenerationCopyWith<$Res> {
  __$$_GenerationCopyWithImpl(
      _$_Generation _value, $Res Function(_$_Generation) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? pokemonSpecies = null,
  }) {
    return _then(_$_Generation(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      pokemonSpecies: null == pokemonSpecies
          ? _value._pokemonSpecies
          : pokemonSpecies // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Generation implements _Generation {
  const _$_Generation(
      {required this.id,
      required this.name,
      @JsonKey(name: 'pokemon_species')
          required final List<dynamic> pokemonSpecies})
      : _pokemonSpecies = pokemonSpecies;

  factory _$_Generation.fromJson(Map<String, dynamic> json) =>
      _$$_GenerationFromJson(json);

  @override
  final int id;
  @override
  final String name;
  final List<dynamic> _pokemonSpecies;
  @override
  @JsonKey(name: 'pokemon_species')
  List<dynamic> get pokemonSpecies {
    if (_pokemonSpecies is EqualUnmodifiableListView) return _pokemonSpecies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pokemonSpecies);
  }

  @override
  String toString() {
    return 'Generation(id: $id, name: $name, pokemonSpecies: $pokemonSpecies)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Generation &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality()
                .equals(other._pokemonSpecies, _pokemonSpecies));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name,
      const DeepCollectionEquality().hash(_pokemonSpecies));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GenerationCopyWith<_$_Generation> get copyWith =>
      __$$_GenerationCopyWithImpl<_$_Generation>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GenerationToJson(
      this,
    );
  }
}

abstract class _Generation implements Generation {
  const factory _Generation(
      {required final int id,
      required final String name,
      @JsonKey(name: 'pokemon_species')
          required final List<dynamic> pokemonSpecies}) = _$_Generation;

  factory _Generation.fromJson(Map<String, dynamic> json) =
      _$_Generation.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  @JsonKey(name: 'pokemon_species')
  List<dynamic> get pokemonSpecies;
  @override
  @JsonKey(ignore: true)
  _$$_GenerationCopyWith<_$_Generation> get copyWith =>
      throw _privateConstructorUsedError;
}
