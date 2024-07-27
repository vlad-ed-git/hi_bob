import 'package:flutter/material.dart';
import 'package:hi_bob/core/ui/containers/containers.dart';
import 'package:hi_bob/core/ui/text/app_text.dart';
import 'package:hi_bob/core/utils/extensions/context_ext.dart';


class PageNotFoundScreen extends StatelessWidget {
  const PageNotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: context.color.errorContainer,
      body: SafeFullScreenContainer(
        Center(
          child: H6('404!', color: context.color.onErrorContainer,),
        ),
      ),
    );
  }
}
