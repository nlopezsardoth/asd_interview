import 'package:asd_app/main.dart';
import 'package:shared_module/config/environments/environment.dart';

Future<void> main() async {
  await runCore(Flavor.prod);
}
