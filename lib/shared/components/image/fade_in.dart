import 'dart:async';

import 'package:flutter/material.dart';

class CustomFadeInWidget extends StatefulWidget {
  final Widget image;
  final Duration duration;

  const CustomFadeInWidget({
    super.key,
    required this.image,
    this.duration = const Duration(milliseconds: 300),
  });

  @override
  State<CustomFadeInWidget> createState() => _CustomFadeInWidgetState();
}

class _CustomFadeInWidgetState extends State<CustomFadeInWidget> {
  double _opacity = 0.0;
  bool _isImageLoaded = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final imageProvider = _getImageProvider(widget.image);
      if (imageProvider != null) {
        final completer = Completer<void>();
        imageProvider
            .resolve(const ImageConfiguration())
            .addListener(
              ImageStreamListener(
                (ImageInfo info, bool sync) {
                  if (!completer.isCompleted) {
                    completer.complete();
                  }
                },
                onError: (dynamic exception, StackTrace? stackTrace) {
                  if (!completer.isCompleted) {
                    completer.completeError(exception, stackTrace);
                  }
                },
              ),
            );
        completer.future.then((_) {
          if (mounted) {
            setState(() {
              _isImageLoaded = true;
              _opacity = 1.0;
            });
          }
        });
      } else {
        _isImageLoaded = true;
        _opacity = 1.0;
      }
    });
  }

  ImageProvider? _getImageProvider(Widget imageWidget) {
    if (imageWidget is Image) {
      return imageWidget.image;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _opacity,
      duration: widget.duration,
      child: _isImageLoaded ? widget.image : const SizedBox(),
    );
  }
}
