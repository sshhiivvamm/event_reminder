import 'package:event_reminder/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CommonLoader extends StatelessWidget {
  const CommonLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.flickr(
        leftDotColor: Colors.blue,
        rightDotColor: EventColors.primarygreen,
        size: 60,
      ),
    );
  }
}
