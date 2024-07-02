import 'package:equatable/equatable.dart';

typedef PostId = String;

class Post extends Equatable {
  const Post({
    required this.id,
    required this.title,
    required this.description,
  });

  final PostId? id;
  final String? title;
  final String? description;

  @override
  List<Object?> get props => [id, title, description];

  factory Post.fromJson(PostId id, Map<String, dynamic> json) {
    return Post(
      id: id,
      title: json['title'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson([bool keepId = false]) {
    return {
      if (keepId) 'id': id,
      'title': title,
      'description': description,
    };
  }

  Post copyWith({
    PostId? id,
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
