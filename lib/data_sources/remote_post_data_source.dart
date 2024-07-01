import 'package:bloc_blog/data_sources/post_data_source.dart';
import 'package:bloc_blog/models/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RemotePostDataSource extends PostDataSource {
  RemotePostDataSource(this._firestore);

  final FirebaseFirestore _firestore;

  static const postsPath = 'posts';
  static String postPath({required String postId}) => '$postsPath/$postId';

  @override
  Future<void> createPost({required Post post}) async {
    final rawPostsCollection = _firestore.collection(postsPath);
    final postsCollection =
        rawPostsCollection.withConverter(fromFirestore: (snapshot, _) {
      return Post.fromJson(snapshot.id, snapshot.data()!);
    }, toFirestore: (post, _) {
      return post.toJson()..remove("id");
    });
    await postsCollection.add(post);
  }

  @override
  Stream<List<Post>> getPosts() {
    final rawPostsCollection = _firestore.collection(postsPath);
    final postsCollection =
        rawPostsCollection.withConverter(fromFirestore: (snapshot, _) {
      return Post.fromJson(snapshot.id, snapshot.data()!);
    }, toFirestore: (post, _) {
      return post.toJson();
    });
    return postsCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  @override
  Stream<Post> getPost({required String postId}) {
    final rawPostDoc = _firestore.doc(postPath(postId: postId));
    final postDoc = rawPostDoc.withConverter(
      fromFirestore: (snapshot, _) {
        return Post.fromJson(snapshot.id, snapshot.data()!);
      },
      toFirestore: (post, _) {
        return post.toJson();
      },
    );
    return postDoc.snapshots().map((snapshot) => snapshot.data()!);
  }

  @override
  Future<void> updatePost({required Post post}) async {
    final postId = post.id!;
    final rawPostDoc = _firestore.doc(postPath(postId: postId));
    final postDoc = rawPostDoc.withConverter(
      fromFirestore: (snapshot, _) {
        return Post.fromJson(snapshot.id, snapshot.data()!);
      },
      toFirestore: (post, _) {
        return post.toJson()..remove("id");
      },
    );
    await postDoc.update(post.toJson());
  }
}
