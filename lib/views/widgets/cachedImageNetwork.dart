import 'package:cached_network_image/cached_network_image.dart';
import 'package:escol/views/shared/general/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CachedImageNetwork extends StatelessWidget {
  final String urlImg;
  final Widget errorWidget;
  final ShimmerDirection direction;
  final Color baseColor;
  final Color highlightColor;
  final Widget childShimmer;
  final BoxShape boxShape;
  final double witdh;
  final double height;
  final BorderRadiusGeometry borderRadius;

  const CachedImageNetwork(
      {Key key,
      @required this.urlImg,
      this.errorWidget,
      this.direction,
      this.baseColor,
      this.highlightColor,
      @required this.childShimmer,
      @required this.witdh,
      @required this.height,
      this.borderRadius,
      this.boxShape})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: '$urlImg',
      imageBuilder: (context, imageProvider) => Container(
        width: witdh,
        height: height,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          borderRadius: borderRadius ?? null,
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
        ),
      ),
      placeholder: (context, url) => Container(
        width: witdh,
        height: height,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: Shimmer.fromColors(
          direction: ShimmerDirection.ltr,
          baseColor: baseColor ?? neutralLighter,
          highlightColor: highlightColor ?? primary,
          child: childShimmer,
        ),
      ),
      errorWidget: (context, url, error) =>
          errorWidget ?? Icon(Icons.error_outline),
    );
  }
}
