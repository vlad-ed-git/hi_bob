import 'package:flutter/material.dart';
import 'package:hi_bob/core/ui/text/app_text.dart';
import 'package:hi_bob/core/utils/extensions/context_ext.dart';

class WordCard extends StatelessWidget {
  final String word;
  final VoidCallback onTap;
  final bool matched, clicked;
  const WordCard({
    super.key,
    required this.word,
    required this.onTap,
    required this.matched,
    required this.clicked,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: clicked || matched ? null : onTap,
      radius: 16,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: context.color.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            width: clicked ? 3 : 1,
            color: matched
                ? context.color.primary
                    : Color(0xFFE5E5E5),
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0xFFE5E5E5),
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
