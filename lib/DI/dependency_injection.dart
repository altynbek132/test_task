import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'dependency_injection.config.dart';

@injectableInit
Future<void> setupLocator() async => GetIt.I.init();
