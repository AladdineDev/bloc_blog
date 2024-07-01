import 'package:equatable/equatable.dart';

class Post extends Equatable {
  const Post({
    required this.id,
    required this.title,
    required this.description,
  });

  final String? id;
  final String? title;
  final String? description;

  @override
  List<Object?> get props => [id, title, description];

  factory Post.fromJson(String id, Map<String, dynamic> json) {
    return Post(
      id: id,
      title: json['title'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }

  Post copyWith({
    String? id,
    String? title,
    String? description,
  }) {
    return Post(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }
}
