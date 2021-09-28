// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html' as html;
import 'dart:js' as js;

import 'package:trendy_movies/src/application/utils/environment_config.dart';

void platformCustomizedInjector() {
  //To expone the dart variable to global js code
  js.context['apiKey'] = EnvironmentConfig.apiKey;
  js.context['authDomain'] = EnvironmentConfig.authDomain;
  js.context['projectId'] = EnvironmentConfig.projectId;
  js.context['storageBucket'] = EnvironmentConfig.storageBucket;
  js.context['messagingSenderId'] = EnvironmentConfig.messagingSenderId;
  js.context['appId'] = EnvironmentConfig.appId;
  js.context['measurementId'] = EnvironmentConfig.measurementId;

  //Custom DOM event to signal to js the execution of the dart code
  html.document.dispatchEvent(html.CustomEvent('secret_data_loaded'));
}
