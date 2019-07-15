import 'package:angular/angular.dart';
import 'package:angular_app/app_component.template.dart' as ng;
import 'package:firebase/firebase.dart' as fb;
import 'package:angular_router/angular_router.dart';

import 'main.template.dart' as self;

@GenerateInjector(
  routerProvidersHash, // You can use routerProviders in production
)
final InjectorFactory injector = self.injector$Injector;

void main() {
  try{
    fb.initializeApp(
      apiKey: "AIzaSyAhZZCySfSBA7XxNcvoFDi6PTvqTOFb4ns",
      authDomain: "navycat-b44e5.firebaseapp.com",
      databaseURL: "https://navycat-b44e5.firebaseio.com",
      projectId: "navycat-b44e5",
      storageBucket: "navycat-b44e5.appspot.com",
      messagingSenderId: "172181932049",
      // appId: "1:172181932049:web:b843616ef298bb7b"
    );
  } on fb.FirebaseJsNotLoadedException catch (e) {
    print(e);
  }

  runApp(ng.AppComponentNgFactory, createInjector: injector);

  // pub run build_runner clean
  // export PATH="$PATH":"$HOME/.pub-cache/bin"
  // webdev serve

}
