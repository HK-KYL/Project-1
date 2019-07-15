import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

@Component(
  selector: 'dashboard-component',
  templateUrl: 'dashboard_component.html',
  // styleUrls: ['dashboard_component.css'],
  directives: [coreDirectives, formDirectives],
)

class DashboardComponent{
  var title = 'Dashboard';
}