import 'package:bloc_blog/data_sources/remote_post_data_source.dart';
import 'package:bloc_blog/models/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

typedef ModelFromFirestore<T> = T Function(
  String id,
  Map<String, dynamic> json,
);
typedef ModelToFirestore<T> = Map<String, Object?> Function(T value);

extension FirebaseFirestoreExtension on FirebaseFirestore {
  CollectionReference<R> collectionWithConverter<R extends Object?>({
    required String collectionPath,
    required ModelFromFirestore<R> fromJson,
    required ModelToFirestore<R> toJson,
  }) {
    final collectionRef = collection(collectionPath);
    return collectionRef.withConverter(
      fromFirestore: (snapshot, _) => fromJson(snapshot.id, snapshot.data()!),
      toFirestore: (value, _) => toJson(value),
    );
  }

  DocumentReference<R> documentWithConverter<R extends Object?>({
    required String documentPath,
    required ModelFromFirestore<R> fromJson,
    required ModelToFirestore<R> toJson,
  }) {
    final docRef = doc(documentPath);
    return docRef.withConverter(
      fromFirestore: (snapshot, _) => fromJson(snapshot.id, snapshot.data()!),
      toFirestore: (value, _) => toJson(value),
    );
  }
}

extension PostFirestoreExtension on FirebaseFirestore {
  CollectionReference<Post> postsCollection() {
    return collectionWithConverter<Post>(
      collectionPath: RemotePostDataSource.postsCollectionPath,
      fromJson: (id, json) => Post.fromJson(id, json),
      toJson: (post) => post.toJson(),
    );
  }

  DocumentReference<Post> postDocument({required String documentPath}) {
    return documentWithConverter<Post>(
      documentPath: documentPath,
      fromJson: (id, json) => Post.fromJson(id, json),
      toJson: (post) => post.toJson(),
    );
  }
}
