import 'package:bloc_blog/data_sources/post_data_source.dart';
import 'package:bloc_blog/extensions/firebase_firestore_extension.dart';
import 'package:bloc_blog/models/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RemotePostDataSource extends PostDataSource {
  RemotePostDataSource(this._firestore);

  final FirebaseFirestore _firestore;

  static const postsCollectionPath = 'posts';
  static String postPath({required PostId postId}) {
    return '$postsCollectionPath/$postId';
  }

  @override
  Future<void> createPost({required Post post}) async {
    final postsCollection = _firestore.postsCollection();
    await postsCollection.add(post);
  }

  @override
  Stream<List<Post>> getPosts({required int limit}) {
    final postsCollection = _firestore.postsCollection();
    final postsQuery = postsCollection.limit(limit);
    return postsQuery.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  @override
  Stream<Post?> getPost({required PostId postId}) {
    final postDoc = _firestore.postDocument(
      documentPath: postPath(postId: postId),
    );
    return postDoc.snapshots().map((snapshot) => snapshot.data());
  }

  @override
  Future<void> updatePost({required Post post}) async {
    final postDoc = _firestore.postDocument(
      documentPath: postPath(postId: post.id!),
    );
    await postDoc.update(post.toJson());
  }

  @override
  Future<void> deletePost({required PostId postId}) async {
    final postDoc = _firestore.postDocument(
      documentPath: postPath(postId: postId),
    );
    await postDoc.delete();
  }
}
