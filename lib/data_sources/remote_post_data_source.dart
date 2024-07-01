import 'package:bloc_blog/data_sources/post_data_source.dart';
import 'package:bloc_blog/extensions/firebase_firestore_extension.dart';
import 'package:bloc_blog/models/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RemotePostDataSource extends PostDataSource {
  RemotePostDataSource(this._firestore);

  final FirebaseFirestore _firestore;

  static const postsCollectionPath = 'posts';
  static String postPath({required String postId}) {
    return '$postsCollectionPath/$postId';
  }

  @override
  Future<void> createPost({required Post post}) async {
    final postsCollection = _firestore.postsCollection();
    await postsCollection.add(post);
  }

  @override
  Stream<List<Post>> getPosts() {
    final postsCollection = _firestore.postsCollection();
    return postsCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  @override
  Stream<Post> getPost({required String postId}) {
    final postDoc = _firestore.postDocument(
      documentPath: postPath(postId: postId),
    );
    return postDoc.snapshots().map((snapshot) => snapshot.data()!);
  }

  @override
  Future<void> updatePost({required Post post}) async {
    final postDoc = _firestore.postDocument(
      documentPath: postPath(postId: post.id!),
    );
    await postDoc.update(post.toJson());
  }
}
