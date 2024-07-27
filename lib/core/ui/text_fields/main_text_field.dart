import 'package:flutter/material.dart';
import 'package:hi_bob/core/ui/assets/app_icons.dart';
import 'package:hi_bob/core/ui/images/svgs/svg_icon.dart';
import 'package:hi_bob/core/ui/text/app_text.dart';
import 'package:hi_bob/core/utils/extensions/context_ext.dart';

class MainTextField extends StatefulWidget {
  final TextInputType keyboardType;
  final TextInputAction? txtInputAction;
  final String hintText, initialValue;
  final Widget? prefix, suffix;
  final String? errorText, prefixText;
  final void Function(String) onChanged, onSubmitted;
  final bool canClear;
  final Color? fillColor;
  final EdgeInsets prefixPadding, contentPadding;

  const MainTextField({
    Key? key,
    required this.hintText,
    this.suffix,
    this.initialValue = '',
    this.errorText,
    required this.onChanged,
    required this.onSubmitted,
    required this.keyboardType,
    this.txtInputAction,
    this.prefix,
    this.prefixText,
    this.canClear = false,
    this.prefixPadding = const EdgeInsets.only(
      right: 8,
      left: 16,
      top: 13,
      bottom: 13,
    ),
    this.contentPadding = const EdgeInsets.only(
      left: 8,
      right: 16,
      top: 13,
      bottom: 13,
    ),
    this.fillColor,
  }) : super(key: key);

  @override
  State<MainTextField> createState() => _MainTextFieldState();
}

class _MainTextFieldState extends State<MainTextField> {
  bool _hasText = false;
  late TextEditingController _controller;
  late FocusNode _focusNode;

  void _onTextChanged(String value) {
    if (value.isEmpty && _hasText) {
      setState(() {
        _hasText = false;
      });
    }
    if (value.isNotEmpty && !_hasText) {
      setState(() {
        _hasText = true;
      });
    }
  }

  void _notifyHasSubmit(String value) {
    _onTextChanged(value);
    widget.onSubmitted(value);
  }

  void _notifyTextChange(String value) {
    _onTextChanged(value);
    widget.onChanged(value);
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    if (_controller.text.isEmpty) {
      _controller.text = widget.initialValue;
    }
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      final bool appendPrefixText =
          _focusNode.hasFocus && widget.prefixText != null;
      if (appendPrefixText) {
        final String currentText = _controller.text;
        final String prefixText = widget.prefixText ?? '';
        if (currentText.startsWith(prefixText)) {
          return;
        }
        _controller.text = prefixText + currentText;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle? txtStyle = (widget.keyboardType == TextInputType.phone ||
            widget.keyboardType == TextInputType.number)
        ? AppTxtStyle.subtitle2.style(context)?.copyWith(
              letterSpacing: 2,
            )
        : AppTxtStyle.p1.style(context);
    return TextFormField(
      textInputAction: widget.txtInputAction ?? TextInputAction.next,
      keyboardType: widget.keyboardType,
      enabled: widget.keyboardType != TextInputType.none,
      showCursor: widget.keyboardType != TextInputType.none,
      obscureText: widget.keyboardType == TextInputType.visiblePassword,
      style: txtStyle,
      controller: _controller,
      focusNode: _focusNode,
      onChanged: _notifyTextChange,
      onFieldSubmitted: _notifyHasSubmit,
      decoration: InputDecoration(
        contentPadding: widget.contentPadding,
        filled: widget.fillColor != null,
        fillColor: widget.fillColor,
        hintStyle: AppTxtStyle.hint.style(context),
        hintText: widget.hintText,
        error: _hasError
            ? HintText(
                widget.errorText ?? '',
                color: context.color.error,
              )
            : null,
        suffixIcon: widget.canClear
            ? _closeBtn
            : widget.suffix == null
                ? null
                : Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: widget.suffix,
                  ),
        prefixIcon: widget.prefix == null
            ? null
            : Padding(
                padding: widget.prefixPadding,
                child: widget.prefix,
              ),
        prefixIconConstraints: BoxConstraints(),
        enabledBorder: _border(enabled: true),
        focusedBorder: _border(focused: true),
        errorBorder: _border(error: true),
        border: _border(enabled: widget.keyboardType != TextInputType.none),
      ),
    );
  }

  bool get _hasError => widget.errorText != null;

  Widget get _closeBtn => InkWell(
        onTap: () {
          _controller.clear();
          widget.onChanged('');
        },
        child: Visibility(
          visible: _hasText,
          child: const ClearIcon(),
        ),
      );

  InputBorder _border({
    bool enabled = false,
    bool focused = false,
    bool error = false,
  }) =>
      UnderlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(
          color: enabled
              ? Colors.transparent
              : focused
                  ? context.color.primary
                  : error
                      ? context.color.error
                      : Colors.transparent,
        ),
      );

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}

class ClearIcon extends StatelessWidget {
  const ClearIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: SizedBox(
        width: 24,
        height: 24,
        child: Center(
          child: Icon(
            Icons.cancel_outlined,
            color: context.color.errorContainer,
            size: 24,
          ),
        ),
      ),
    );
  }
}
