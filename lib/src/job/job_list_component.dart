import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
//import 'dialog_service.dart';

// _firebaseService
import '../services/firebase_service.dart';

import 'job_routes.dart';
import 'job_route_paths.dart';
import 'job.dart';

@Component(
  selector: 'job-list-component',
  templateUrl: 'job_list_component.html',
  directives: [routerDirectives, coreDirectives, RouterOutlet],
  exports: [JobRoutePaths, JobRoutes],
  styleUrls: ['job_list_component.css'],
)
class JobListComponent with CanReuse implements OnActivate, OnInit {

  final Router _router;
  final FirebaseService _firebaseService;

  List<Job> jobs;
  String selected;
  
  JobListComponent(this._router, this._firebaseService);
  
  @override
  void ngOnInit() {
    print('OnInit');
    _getJobs();
  }

  Future<void> _getJobs() async {
    this.jobs = await _firebaseService.loadItems();
  }

  // Future<void> _getJobsByUid() async {
  //   this.crises = await _firebaseService.loadItemsByUid();
  // }
  
  @override
  void onActivate(_, RouterState current) {
    print('OnActivate');
    selected = _select(current);
  }
  
  String _select(RouterState routerState) {
    final id = getId(routerState.parameters);
    return id == null ? null : id;
  }
  
  void onSelect(Job job) => _gotoDetail(job.id);

  Future<NavigationResult> _gotoDetail(String id) =>
    _router.navigate(_jobUrl(id));
  
  String _jobUrl(String id) =>
    JobRoutePaths.job.toUrl(parameters: {idParam: '$id'});
  
}
