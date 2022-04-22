import 'package:flutter/material.dart';

import '../../factories.dart';
import '../../../../ui/pages/pages.dart';

Widget makeSplashPage() => SplashPage(
  presenter: makeGetxSplashPresenter(),
);
