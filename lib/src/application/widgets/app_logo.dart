import 'package:flutter/material.dart';
import 'package:trendy_movies/src/application/assets.dart';
import 'package:trendy_movies/src/application/localisation/keys.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({this.showAppName = false, Key? key}) : super(key: key);
  final bool showAppName;
  @override
  Widget build(BuildContext context) {
    final imageLogo = Image.asset(
      AssetResources.logo,
      width: 150,
    );

    return !showAppName
        ? imageLogo
        : Column(
            children: [
              imageLogo,
              const SizedBox(
                height: 10,
              ),
              Text(
                Keys.App_Name.trans.toUpperCase(),
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          );
  }
}
