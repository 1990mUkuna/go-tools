import 'package:equatable/equatable.dart';

class ArticleSource extends Equatable {
  final String id;
  final String name;

  ArticleSource({
    this.id,
    this.name,
  });

  factory ArticleSource.fromJson(Map<String, dynamic> json) {
    return ArticleSource(
      id: json["id"] == null ? null : json["id"],
      name: json["name"],
    );
  }

  @override
  List<Object> get props => [
        id,
        name,
      ];
}
