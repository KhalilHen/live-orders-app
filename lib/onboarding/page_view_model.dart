import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter/material.dart';
import 'package:live_order_apps/onboarding/explain_page.dart';
import 'package:live_order_apps/onboarding/pages/ending_page.dart';
import 'package:live_order_apps/onboarding/pages/introduction.dart';

List<PageViewModel> getPages() {
  return [startPage(), explainPage(), endingPage()];
}
