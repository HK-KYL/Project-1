import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';

// _firebaseService
import '../services/firebase_service.dart';

import 'job_route_paths.dart';
import 'job.dart';

@Component(
  selector: 'job-component',
  templateUrl: 'job_component.html',
  directives: [coreDirectives, formDirectives],
)
class JobComponent implements OnActivate {
  
  final Router _router;
  final FirebaseService _firebaseService;

  Job job;
  bool isNotLoading;
  String uid;

  JobComponent(this._router, this._firebaseService);

  @override
  void onActivate(_, RouterState current) async {
    isNotLoading = false;
    final String id = getId(current.parameters);

    if (id != null) {
      job = await this._firebaseService.loadItem(id);
      getDisplayName().then((name){
        job.createdBy = name;
        isNotLoading = true;
      });
    }
    
  }

  goBack() {
    _router.navigate(JobRoutePaths.home.toUrl());
  }

  Future<String> getDisplayName() async {
    return await this._firebaseService.getUserDisplayNameByUid(job.createdBy);
  }

  updateJob(Job job) async{
    await this._firebaseService.updateItem(job);
  }

  deleteJob(String jid) async {
    await this._firebaseService.deleteItem(jid);
  }

  bool isCreator() {
    return uid == this._firebaseService.user.uid;
  }

}