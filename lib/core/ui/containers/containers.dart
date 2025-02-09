import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hi_bob/core/utils/extensions/context_ext.dart';

class SafeFullScreenContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;

  const SafeFullScreenContainer(
    this.child, {
    super.key,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final content = Container(
      padding: padding ?? EdgeInsets.zero,
      width: context.maxAllowedScreenWidth,
      height: context.screenHeight,
      child: child,
    );
    return SafeArea(
      maintainBottomViewPadding: true,
      child: kIsWeb ? Container(
        width: context.trueScreenWidth,
        height: context.screenHeight,
        alignment: Alignment.center,
        child: content,
        ) : content,
    );
  }
}

class LeftCenteredInRow extends StatelessWidget {
  final List<Widget> children;

  const LeftCenteredInRow(this.children, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: children,
    );
  }
}

class TopLeftColumn extends StatelessWidget {
  final List<Widget> children;

  const TopLeftColumn(this.children, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }
}

class CenterColumn extends StatelessWidget {
  final List<Widget> children;

  const CenterColumn(this.children, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }
}

class CenterLeftColumn extends StatelessWidget {
  final List<Widget> children;

  const CenterLeftColumn(this.children, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }
}

class SpaceBtnCenterRow extends StatelessWidget {
  final List<Widget> children;

  const SpaceBtnCenterRow(this.children, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: children,
    );
  }
}

class CenterRow extends StatelessWidget {
  final List<Widget> children;

  const CenterRow(this.children, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }
}

class WrapHorizontally extends StatelessWidget {
  final List<Widget> children;
  final double? widthOrFullScreen, spacing;

  const WrapHorizontally(
    this.children, {
    super.key,
    this.widthOrFullScreen,
    this.spacing,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: widthOrFullScreen ?? context.maxAllowedScreenWidth,
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: spacing ?? 0.0,
        runSpacing: spacing ?? 0.0,
        children: children,
      ),
    );
  }
}
