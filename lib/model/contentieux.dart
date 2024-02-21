import 'dart:convert';

class Contentieux {
  final Total total;
  final int max_score;
  final List<Hit> hits;
  Contentieux({
    required this.total,
    required this.max_score,
    required this.hits,
  });

  Contentieux copyWith({
    Total? total,
    int? max_score,
    List<Hit>? hits,
  }) {
    return Contentieux(
      total: total ?? this.total,
      max_score: max_score ?? this.max_score,
      hits: hits ?? this.hits,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'total': total.toMap(),
      'max_score': max_score,
      'hits': hits.map((x) => x.toMap()).toList(),
    };
  }

  factory Contentieux.fromMap(Map<String, dynamic> map) {
    return Contentieux(
      total: Total.fromMap(map['total'] as Map<String, dynamic>),
      max_score: map['max_score'].toInt() as int,
      hits: List<Hit>.from(
        (map['hits'] as List).map<Hit>(
          (x) => Hit.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Contentieux.fromJson(String source) =>
      Contentieux.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Contentieux(total: $total, max_score: $max_score, hits: $hits)';

  @override
  bool operator ==(covariant Contentieux other) {
    if (identical(this, other)) return true;

    return other.total == total && other.max_score == max_score;
  }

  @override
  int get hashCode => total.hashCode ^ max_score.hashCode ^ hits.hashCode;
}

class Total {
  final int value;
  final String relation;
  Total({
    required this.value,
    required this.relation,
  });

  Total copyWith({
    int? value,
    String? relation,
  }) {
    return Total(
      value: value ?? this.value,
      relation: relation ?? this.relation,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'value': value,
      'relation': relation,
    };
  }

  factory Total.fromMap(Map<String, dynamic> map) {
    return Total(
      value: map['value'].toInt() as int,
      relation: map['relation'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Total.fromJson(String source) =>
      Total.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Total(value: $value, relation: $relation)';

  @override
  bool operator ==(covariant Total other) {
    if (identical(this, other)) return true;

    return other.value == value && other.relation == relation;
  }

  @override
  int get hashCode => value.hashCode ^ relation.hashCode;
}

class Hit {
  final Source source;
  Hit({
    required this.source,
  });

  Hit copyWith({
    Source? source,
  }) {
    return Hit(
      source: source ?? this.source,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_source': source.toMap(),
    };
  }

  factory Hit.fromMap(Map<String, dynamic> map) {
    return Hit(
      source: Source.fromMap(map['_source'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Hit.fromJson(String source) =>
      Hit.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Hit(_source: $source)';

  @override
  bool operator ==(covariant Hit other) {
    if (identical(this, other)) return true;

    return other.source == source;
  }

  @override
  int get hashCode => source.hashCode;
}

class CustomHit {
  bool status;
  final Source source;
  CustomHit({
    required this.source,
    required this.status,
  });

  CustomHit copyWith({
    Source? source,
    bool? status,
  }) {
    return CustomHit(
      source: source ?? this.source,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_source': source.toMap(),
    };
  }

  @override
  bool operator ==(covariant Hit other) {
    if (identical(this, other)) return true;

    return other.source == source;
  }

  @override
  int get hashCode => source.hashCode;
}

class Source {
  final String host;
  final String abonnement;
  final String codeclient;
  final int jrs;
  final double upload;
  final double download;
  Source({
    required this.host,
    required this.abonnement,
    required this.codeclient,
    required this.jrs,
    required this.upload,
    required this.download,
  });

  Source copyWith({
    String? host,
    String? abonnement,
    String? codeclient,
    int? jrs,
    double? upload,
    double? download,
  }) {
    return Source(
      host: host ?? this.host,
      abonnement: abonnement ?? this.abonnement,
      codeclient: codeclient ?? this.codeclient,
      jrs: jrs ?? this.jrs,
      upload: upload ?? this.upload,
      download: download ?? this.download,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'host': host,
      'abonnement': abonnement,
      'codeclient': codeclient,
      'duration(jrs)': jrs,
      'upload(Go)': upload,
      'download(Go)': download,
    };
  }

  factory Source.fromMap(Map<String, dynamic> map) {
    return Source(
      host: map['host'] as String,
      abonnement: map['abonnement'] as String,
      codeclient: map['code client'],
      jrs: map['duration (jrs)'].toInt() as int,
      upload: map['upload (Go)'].toDouble() as double,
      download: map['download (Go)'].toDouble() as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Source.fromJson(String source) =>
      Source.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return '_source(host: $host, abonnement: $abonnement, codeclient: $codeclient, duration(jrs): $jrs, upload(Go): $upload, download(Go): $download)';
  }

  @override
  bool operator ==(covariant Source other) {
    if (identical(this, other)) return true;

    return other.host == host &&
        other.abonnement == abonnement &&
        other.codeclient == codeclient &&
        other.jrs == jrs &&
        other.upload == upload &&
        other.download == download;
  }

  @override
  int get hashCode {
    return host.hashCode ^
        abonnement.hashCode ^
        codeclient.hashCode ^
        jrs.hashCode ^
        upload.hashCode ^
        download.hashCode;
  }
}
