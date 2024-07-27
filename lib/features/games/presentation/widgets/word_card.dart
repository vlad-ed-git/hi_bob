import 'package:flutter/material.dart';
import 'package:hi_bob/core/ui/text/app_text.dart';
import 'package:hi_bob/core/utils/extensions/context_ext.dart';

class WordCard extends StatelessWidget {
  final String word;
  final VoidCallback? onTap;
  final bool highlightAsMatched, highlightAsClicked, highlightAsError;
  const WordCard({
    super.key,
    required this.word,
    this.onTap,
    this.highlightAsMatched = false,
    this.highlightAsClicked = false,
    this.highlightAsError = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (highlightAsClicked || highlightAsMatched) ? null : onTap,
      radius: 16,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: context.color.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            width: (highlightAsClicked || highlightAsMatched) ? 3 : 1,
            color: highlightAsError ? context.color.error :
              highlightAsMatched
                ? context.color.primary
                    : Color(0xFFE5E5E5),
          ),
          boxShadow: [
            BoxShadow(
              color: highlightAsError ? context.color.error : Color(0xFFE5E5E5),
              offset: Offset(0, 2), // vertical shadow
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 16),
        child: P1(
          word,
          color: context.color.onSurface,
          txtAlign: TextAlign.center,
        ),
      ),
    );
  }
}
