import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

class ParentLoaderOverlay {
  BuildContext? context;

  ParentLoaderOverlay([this.context]);

  void show() {
    context?.loaderOverlay.show();
  }

  void hide() {
    context?.loaderOverlay.hide();
  }
}
