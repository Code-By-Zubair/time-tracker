import 'package:flutter/material.dart';

class Loader {
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  void loadingState(bool loadingState) {
    isLoading.value = loadingState;
  }
}
