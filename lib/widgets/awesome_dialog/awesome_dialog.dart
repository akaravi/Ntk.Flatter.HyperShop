import 'vertical_stack_header_dialog.dart';

import 'animated_button.dart';
import 'package:flutter/material.dart';
import 'anims/flare_header.dart';
import 'anims/anims.dart';

enum DialogType { INFO, WARNING, ERROR, SUCCES }
enum AnimType { SCALE, LEFTSLIDE, RIGHSLIDE, BOTTOMSLIDE, TOPSLIDE }

class AwesomeDialog {
  final DialogType dialogType;
  final Widget customHeader;
  final String tittle;
  final String desc;
  final BuildContext context;
  final String btnOkText;
  final IconData btnOkIcon;
  final Function btnOkOnPress;
  final Color btnOkColor;
  final String btnCancelText;
  final IconData btnCancelIcon;
  final Function btnCancelOnPress;
  final Color btnCancelColor;
  final Widget btnOk;
  final Widget btnCancel;
  final Widget body;
  final bool dismissOnTouchOutside;
  final Function onDissmissCallback;
  final AnimType animType;
  final TextAlign descTextAlign;
  AwesomeDialog(
      {@required this.context,
      this.dialogType,
      this.customHeader,
      this.tittle,
      this.desc,
      this.body,
      this.btnOk,
      this.btnCancel,
      this.btnOkText,
      this.btnOkIcon,
      this.btnOkOnPress,
      this.btnOkColor,
      this.btnCancelText,
      this.btnCancelIcon,
      this.btnCancelOnPress,
      this.btnCancelColor,
      this.onDissmissCallback,
      this.dismissOnTouchOutside = true,
      this.descTextAlign,
      this.animType = AnimType.SCALE})
      : assert(
          (dialogType != null || customHeader != null),
          context != null,
        );

  Future show() {
    return showDialog(
        context: this.context,
        barrierDismissible: dismissOnTouchOutside,
        builder: (BuildContext context) {
          switch (animType) {
            case AnimType.SCALE:
              return Scale(
                  scalebegin: 0.1,
                  curve: Curves.fastLinearToSlowEaseIn,
                  child: _buildDialog());
              break;
            case AnimType.LEFTSLIDE:
              return Slide(from: SlideFrom.LEFT, child: _buildDialog());
              break;
            case AnimType.RIGHSLIDE:
              return Slide(from: SlideFrom.RIGHT, child: _buildDialog());
              break;
            case AnimType.BOTTOMSLIDE:
              return Slide(from: SlideFrom.BOTTOM, child: _buildDialog());
              break;
            case AnimType.TOPSLIDE:
              return Slide(from: SlideFrom.TOP, child: _buildDialog());
              break;
            default:
              return _buildDialog();
          }
        }).then((_) {
      if (onDissmissCallback != null) onDissmissCallback();
    });
  }

  _buildDialog() {
    return VerticalStackDialog(
      header: customHeader ??
          FlareHeader(
            dialogType: this.dialogType,
          ),
      descTextAlign: descTextAlign,
      title: this.tittle,
      desc: this.desc,
      body: this.body,
      btnOk: btnOk ?? (btnOkOnPress != null ? _buildFancyButtonOk() : null),
      btnCancel: btnCancel ??
          (btnCancelOnPress != null ? _buildFancyButtonCancel() : null),
    );
  }

  _buildFancyButtonOk() {
    return AnimatedButton(
      pressEvent: () {
        Navigator.of(context).pop();
        btnOkOnPress();
      },
      text: btnOkText ?? 'تایید',
      color: btnOkColor ?? Color(0xFF00CA71),
      icon: btnOkIcon,
    );
  }

  _buildFancyButtonCancel() {
    return AnimatedButton(
      pressEvent: () {
        Navigator.of(context).pop();
        btnCancelOnPress();
      },
      text: btnCancelText ?? 'انصراف',
      color: btnCancelColor ?? Colors.red,
      icon: btnCancelIcon,
    );
  }

  dissmiss() {
    Navigator.of(context).pop();
  }
}
