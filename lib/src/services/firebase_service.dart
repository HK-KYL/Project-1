import 'dart:async';
import 'package:angular/angular.dart';

import 'package:firebase/firebase.dart' as fb;
import 'package:firebase/firestore.dart' as fs;

import '../job/job.dart';

@Injectable()
class FirebaseService {
  
  final fb.Auth auth;
  final fb.DatabaseReference databaseRef;
  final fb.StorageReference storageRef;
  final fs.CollectionReference fsRef_jobs;
  final fs.CollectionReference fsRef_users;

  final List<Job> jobs = [];
  Job job;
  fb.User user;
  bool loading = true;

  FirebaseService()
      : auth = fb.auth(),
        databaseRef = fb.database().ref("jobs"),
        storageRef = fb.storage().ref("jobs"),
        fsRef_jobs = fb.firestore().collection('jobs'),
        fsRef_users = fb.firestore().collection('users');

  init() {
    // databaseRef.onChildAdded.listen((e) {
    //   // Snapshot of the data.
    //   fb.DataSnapshot data = e.snapshot;

    //   // Value of data from snapshot.
    //   var val = data.val();
    //   // Creates a new Note item. It is possible to retrieve a key from data.
    //   var item = new Note(
    //       val[jsonTagText], val[jsonTagTitle], val[jsonTagImgUrl], data.key);
    //   jobs.insert(0, item);
    // });

    // // Setups listening on the child_removed event on the database ref.
    // databaseRef.onChildRemoved.listen((e) {
    //   fb.DataSnapshot data = e.snapshot;
    //   var val = data.val();

    //   // Removes also the image from storage.
    //   var imageUrl = val[jsonTagImgUrl];
    //   if (imageUrl != null) {
    //     removeItemImage(imageUrl);
    //   }
    //   notes.removeWhere((n) => n.key == data.key);
    // });

    // Sets loading to true when path changes
    databaseRef.onValue.listen((e) {
      loading = false;
    });

    // Sets user when auth state changes
    auth.onIdTokenChanged.listen((e) {
      user = e;
    });

    auth.onAuthStateChanged.listen((user){
      print('onAuthStateChanged');
      if(user != null){
        print('fsRef_users');
        fsRef_users.doc(user.uid).set({
          'name': user.displayName,
          'email': user.email,
          'photo': user.photoURL,
        }, fs.SetOptions(merge: true));
      }
    });

  }

  Future<String> getUserDisplayNameByUid(String uid) async {
    var data;
    await this.fsRef_users.doc(uid).get().then((user) {
      if(user.exists)
        data = user.data();
    });
    return data['name'];
  }

  Future<List<Job>> loadItems() async {
    await this.fsRef_jobs.orderBy("createdAt").get().then((docs) {
      docs.forEach((doc){
        var data = doc.data();
        data.putIfAbsent('id', ()=> doc.id);
        this.jobs.add(Job.fromMap(data));
      });
    });
    
    return this.jobs;
  }

  // Future<List<Job>> loadItemsByUid() async {

  //   // await this.fsRef_jobs.orderBy("id").onSnapshot.listen((querySnapshot) {
  //   //   for (var change in querySnapshot.docChanges()) {
  //   //     var docSnapshot = change.doc;
  //   //     String id = docSnapshot.id;
  //   //     String name = docSnapshot.data().values.toList()[1];
  //   //     jobs.add(Job(id, name));
  //   //   }
  //   // });
  //   // return jobs;

  //   await this.fsRef_jobs.where('createdBy', '==', user.uid).orderBy("createdAt").get().then((docs) {
  //     docs.forEach((doc){
  //       var data = doc.data();
  //       data.putIfAbsent('id', ()=> doc.id);
  //       this.jobs.add(Job.fromMap(data));
  //     });
  //   });
    
  //   return this.jobs;
  // }

  Future<Job> loadItem(String id) async {
    var data;

    await this.fsRef_jobs.doc(id).get().then((doc) {
      data = doc.data();
      data.putIfAbsent('id', ()=> doc.id);
    }).catchError((e){print(e);});

    return Job.fromMap(data);
  }

  deleteItem(String id) async {
    await this.fsRef_jobs.doc(id).delete().then((ok) {
      print("Done");
    }).catchError((e){print(e);});
    
  }

  // Pushes a new item as a Map to database.
  postItem(Job item) async {
    // try {
    //   await databaseRef.push(Job.toMap(item)).future;
    //   print('ok');
    // } catch (e) {
    //   print("Error in writing to database: $e");
    // }

    item.createdBy = user.uid;

    try {
      await fsRef_jobs.add(
        Job.toMap(item)
      ).then((e) {
        print(e);
      });
    } catch (e) {
      print("Error while writing document, $e");
    }
  }

  updateItem(Job item) async {
    item.createdBy = user.uid;

    try {
      await fsRef_jobs.doc(item.id).set(
        Job.toMap(item)
      ).then((e) {
        print("Updated");
      });
      
    } catch (e) {
      print("Error while writing document, $e");
    }
  }

  // // Removes item with a key from database.
  // removeItem(String key) async {
  //   try {
  //     await databaseRef.child(key).remove();
  //   } catch (e) {
  //     print("Error in deleting $key: $e");
  //   }
  // }

  // // Puts image into a storage.
  // postItemImage(File file) async {
  //   try {
  //     var task = storageRef.child(file.name).put(file);
  //     task.onStateChanged
  //         .listen((_) => loading = true, onDone: () => loading = false);

  //     var snapshot = await task.future;
  //     return snapshot.downloadURL;
  //   } catch (e) {
  //     print("Error in uploading to storage: $e");
  //   }
  // }

  // // Removes image with an imageUrl from the storage.
  // removeItemImage(String imageUrl) async {
  //   try {
  //     var imageRef = fb.storage().refFromURL(imageUrl);
  //     await imageRef.delete();
  //   } catch (e) {
  //     print("Error in deleting $imageUrl: $e");
  //   }
  // }

  // Signs in with the Google auth provider.
  signInWithGoogle() async {
    var provider = fb.GoogleAuthProvider();
    try {
      await auth.signInWithPopup(provider);
    } catch (e) {
      print("Error in sign in with Google: $e");
    }
  }

  signOut() async {
    await auth.signOut();
  }
}