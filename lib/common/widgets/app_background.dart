import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:weathertrack/core/constants/image_paths.dart';

class AppBackground extends StatelessWidget {
  final Widget? child;

  const AppBackground({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImagePaths.appBackground),
          fit: BoxFit.cover,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
        child: child,
      ),
    );
  }
}
