import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:firebase/firebase.dart' as fb;

// _firebaseService
import 'package:angular_app/src/services/firebase_service.dart';

import '../app_route_paths.dart';

@Component(
  selector: 'navbar-component',
  template: 
  '''

    <button [routerLink]="AppRoutePaths.dashboard.toUrl()">Dashboard</button>
    <button [routerLink]="AppRoutePaths.jobs.toUrl()">Job</button>

    <button *ngIf="fbS.user == null" (click)="signInWithGoogle()">Google</button>
    
    <div *ngIf="fbS.user != null" style="float: right">
    <img src="{{fbS.user.photoURL}}" height="42" width="42">
      <p style="display: inline-block; margin: 1em;">{{fbS.user.displayName}}</p>
      <button (click)="signOut()">Out</button>
    </div>

  ''',
  directives: [routerDirectives, coreDirectives],
  exports: [AppRoutePaths],
)
class navbarComponent implements OnInit{

  final FirebaseService _firebaseService;

  FirebaseService fbS;

  navbarComponent(this._firebaseService);

  @override
  void ngOnInit() {
    fbS = this._firebaseService;
  }

  signInWithGoogle() async {
    await this._firebaseService.signInWithGoogle();
  }

  signOut() async {
    await this._firebaseService.signOut();
  }
  
}