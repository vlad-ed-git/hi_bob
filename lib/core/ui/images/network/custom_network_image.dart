import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hi_bob/core/ui/loading/round_loading_indicator.dart';

class CustomNetworkImage extends StatelessWidget {
  final String imageUrl;

  final double imageSize;

  final bool showLoading;

  final BoxDecoration decoration;

  final EdgeInsets? margin;

  const CustomNetworkImage({
    Key? key,
    required this.imageUrl,
    required this.imageSize,
    this.showLoading = true,
    this.decoration = const BoxDecoration(),
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: imageSize,
        height: imageSize,
        fit: BoxFit.cover,
        filterQuality: FilterQuality.high,
        imageBuilder: (context, imageProvider) => Container(
          decoration: decoration.copyWith(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        progressIndicatorBuilder: (context, url, _) => RoundLoadingIndicator(),
        errorWidget: (context, url, dynamic error) {
          return SizedBox.shrink();
        },
      ),
    );
  }
}
