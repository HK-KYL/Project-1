import 'package:angular/angular.dart';
import 'package:angular_app/src/services/firebase_service.dart';
import 'package:angular_app/src/navbar_component.dart';
import 'package:angular_router/angular_router.dart';
import 'app_routes.dart';

@Component(
  selector: 'my-app',
  template: 
  '''

    <navbar-component></navbar-component>
    <br>
    <router-outlet [routes]="AppRoutes.all"></router-outlet>
  
  ''',
  directives: [routerDirectives, navbarComponent],
  providers: [ClassProvider(FirebaseService)],
  exports: [AppRoutes],
)
class AppComponent with CanReuse implements OnInit{
  var name = 'Angular';
  
  final FirebaseService _firebaseService;

  AppComponent(this._firebaseService);

  @override
  void ngOnInit() {
    this._firebaseService.init();
  }

}