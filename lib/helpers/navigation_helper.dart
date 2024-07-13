import 'package:flutter/material.dart';

gotoNextPagePush(BuildContext context, Widget nextPage) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => nextPage));
}

gotoNextPageRemoveUntill(BuildContext context, Widget nextPage) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => nextPage), (route) => false);
}
