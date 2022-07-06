import 'dart:convert';

import 'package:flutter/foundation.dart';

class KurdishNamesModal {
  final List<Name> names;
  final int recordCount;
  KurdishNamesModal({
    required this.names,
    required this.recordCount,
  });

  KurdishNamesModal copyWith({
    List<Name>? names,
    int? recordCount,
  }) {
    return KurdishNamesModal(
      names: names ?? this.names,
      recordCount: recordCount ?? this.recordCount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'names': names.map((x) => x.toMap()).toList(),
      'recordCount': recordCount,
    };
  }

  factory KurdishNamesModal.fromMap(Map<String, dynamic> map) {
    return KurdishNamesModal(
      names: List<Name>.from(
        (map['names'] as List<dynamic>).map<Name>(
          (x) => Name.fromMap(x as Map<String, dynamic>),
        ),
      ),
      recordCount: map['recordCount'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory KurdishNamesModal.fromJson(String source) =>
      KurdishNamesModal.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'KurdishNamesModal(names: $names, recordCount: $recordCount)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    //final listEquals = const DeepCollectionEquality().equals;

    return other is KurdishNamesModal &&
        listEquals(other.names, names) &&
        other.recordCount == recordCount;
  }

  @override
  int get hashCode => names.hashCode ^ recordCount.hashCode;
}

class Name {
  final int nameId;
  final String name;
  final String desc;
  final String gender;
  final int positiveVotes;
  final int negativeVotes;
  Name({
    required this.nameId,
    required this.name,
    required this.desc,
    required this.gender,
    required this.positiveVotes,
    required this.negativeVotes,
  });

  Name copyWith({
    int? nameId,
    String? name,
    String? desc,
    String? gender,
    int? positiveVotes,
    int? negativeVotes,
  }) {
    return Name(
      nameId: nameId ?? this.nameId,
      name: name ?? this.name,
      desc: desc ?? this.desc,
      gender: gender ?? this.gender,
      positiveVotes: positiveVotes ?? this.positiveVotes,
      negativeVotes: negativeVotes ?? this.negativeVotes,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nameId': nameId,
      'name': name,
      'desc': desc,
      'gender': gender,
      'positiveVote': positiveVotes,
      'negativeVote': negativeVotes,
    };
  }

  factory Name.fromMap(Map<String, dynamic> map) {
    return Name(
      nameId: map['nameId'] as int,
      name: map['name'] as String,
      desc: map['desc'] as String,
      gender: map['gender'] as String,
      positiveVotes: map['positive_votes'] as int,
      negativeVotes: map['negative_votes'] as int,
    );
  }
  String toJson() => json.encode(toMap());

  factory Name.fromJson(String source) =>
      Name.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Name(nameId: $nameId, name: $name, desc: $desc, gender: $gender, positive_votes: $positiveVotes, negative_votes: $negativeVotes)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Name &&
        other.nameId == nameId &&
        other.name == name &&
        other.desc == desc &&
        other.gender == gender &&
        other.positiveVotes == positiveVotes &&
        other.negativeVotes == negativeVotes;
  }

  @override
  int get hashCode {
    return nameId.hashCode ^
        name.hashCode ^
        desc.hashCode ^
        gender.hashCode ^
        positiveVotes.hashCode ^
        negativeVotes.hashCode;
  }
}
