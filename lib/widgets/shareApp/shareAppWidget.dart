// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:most_sport/constants.dart';
import 'package:share/share.dart';

void shareApp(BuildContext context) {
  const String text = textForShare;
  const String link = appLinkForShare;

  final RenderBox box = context.findRenderObject() as RenderBox;

  Share.share(
    '$text\n$link',
    subject: 'Share via',
    sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
  );
}
