import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hi_bob/core/services/audio/domain/audio_service.dart';
import 'package:hi_bob/core/ui/containers/containers.dart';
import 'package:hi_bob/core/ui/text/app_text.dart';
import 'package:hi_bob/core/utils/extensions/context_ext.dart';
import 'package:hi_bob/core/utils/extensions/string_ext.dart';

class WordCard extends StatelessWidget {
  final String word;
  final VoidCallback? onTap;
  final bool highlightAsMatched, playAudioOnClick, highlightAsClicked, highlightAsError;
  const WordCard({
    super.key,
    required this.word,
    this.onTap,
    this.highlightAsMatched = false,
    this.highlightAsClicked = false,
    this.highlightAsError = false,
    this.playAudioOnClick = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async{
        final bool disabled = highlightAsClicked || highlightAsMatched;
        if(disabled){
          return;
        }
        onTap?.call();
        if(playAudioOnClick)
        await GetIt.I<MAudioService>().playAndRelease(word);
      },
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
        child: LeftCenteredInRow(
          [
            if(playAudioOnClick)...[
              Icon(
                Icons.multitrack_audio,
                color: context.color.primaryContainer,
              ),
              SizedBox(width: 8,),
            ],
            P1(
              word,
              color: context.color.onSurface,
              txtAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
