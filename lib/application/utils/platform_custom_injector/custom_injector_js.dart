import 'dart:html' as html;
import 'dart:js' as js;

import 'package:flutter_dotenv/flutter_dotenv.dart';

void platformCustomizedInjector() {
  //To expone the dart variable to global js code
  js.context['apiKey'] = dotenv.env['API_KEY'];
  js.context['authDomain'] = dotenv.env['AUTH_DOMAIN'];
  js.context['projectId'] = dotenv.env['PROJECT_ID'];
  js.context['storageBucket'] = dotenv.env['STORAGE_BUCKET'];
  js.context['messagingSenderId'] = dotenv.env['MESSAGING_SENDER_ID'];
  js.context['appId'] = dotenv.env['APP_ID'];
  js.context['measurementId'] = dotenv.env['MEASUREMENT_ID'];

  //Custom DOM event to signal to js the execution of the dart code
  html.document.dispatchEvent(html.CustomEvent('secret_data_loaded'));
}
