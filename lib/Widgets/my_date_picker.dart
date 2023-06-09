import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker_constants.dart';
import 'package:flutter_holo_date_picker/date_picker_theme.dart';
import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';
import 'package:flutter_holo_date_picker/widget/date_picker_widget.dart';



enum DateTimePickerMode {
  /// Display DatePicker
  date,

  /// Display DateTimePicker
  datetime,
}

class MyDatePicker {
  /// Display date picker in bottom sheet.
  ///
  /// context: [BuildContext]
  /// firstDate: [DateTime] minimum date time
  /// lastDate: [DateTime] maximum date time
  /// initialDateTime: [DateTime] initial date time for selected
  /// dateFormat: [String] date format pattern
  /// locale: [DateTimePickerLocale] internationalization
  /// backgroundColor: [Color] background color of the dialog
  /// itemTextStyle: [TextStyle] item TextStyle of the picker
  /// titleText: [String] text of the dialog's title
  /// confirmText: [String] text of the dialog's confirm button
  /// cancelText: [String] text of the dialog's  cancel button
  static Future<DateTime> showSimpleDatePicker(
      BuildContext context, {
        DateTime firstDate,
        DateTime lastDate,
        DateTime initialDate,
        String dateFormat,
        DateTimePickerLocale locale: DATETIME_PICKER_LOCALE_DEFAULT,
        DateTimePickerMode pickerMode: DateTimePickerMode.date,
        Color backgroundColor,
        Color textColor,
        //TextStyle itemTextStyle,
        String titleText,
        String confirmText,
        String cancelText,
        bool looping: false,
      }) {
    DateTime _selectedDate = initialDate;

    // handle the range of datetime
    if (firstDate == null) {
      firstDate = DateTime.parse(DATE_PICKER_MIN_DATETIME);
    }
    if (lastDate == null) {
      lastDate = DateTime.parse(DATE_PICKER_MAX_DATETIME);
    }

    // handle initial DateTime
    if (initialDate == null) {
      initialDate = DateTime.now();
    }

    if (backgroundColor == null)
      backgroundColor = DateTimePickerTheme.Default.backgroundColor;
//    if (itemTextStyle == null)
//      itemTextStyle = DateTimePickerTheme.Default.itemTextStyle;

    if (textColor == null)
      textColor = DateTimePickerTheme.Default.itemTextStyle.color;

    var datePickerDialog = AlertDialog(
      title: Text(
        titleText ?? "Select Date",
        style: TextStyle(color: textColor),
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 14),
      backgroundColor: backgroundColor,
      content: Container(
        width: 300,
        child: DatePickerWidget(
          firstDate: firstDate,
          lastDate: lastDate,
          initialDate: initialDate,
          dateFormat: dateFormat,
          locale: locale,
          pickerTheme: DateTimePickerTheme(
            backgroundColor: backgroundColor,
            itemTextStyle: TextStyle(color: textColor),
          ),
          onChange: ((DateTime date, list) {
            _selectedDate = date;
          }),
          looping: looping,
        ),
      ),
      actions: <Widget>[
       ElevatedButton(
          //textColor: textColor,
          child: Text(confirmText ?? "OK"),
          onPressed: () {
            Navigator.pop(context, _selectedDate);
          },
        ),
   /*     FlatButton(
          textColor: textColor,
          child: Text(cancelText ?? "Cancel"),
          onPressed: () {
            Navigator.pop(context);
          },
        )*/
      ],
    );
    return showDialog(
        useRootNavigator: false,
        context: context,
        barrierDismissible: false,
        builder: (context) => datePickerDialog);
  }
}

class _DatePickerRoute<T> extends PopupRoute<T> {
  _DatePickerRoute({
    this.minDateTime,
    this.maxDateTime,
    this.initialDateTime,
    this.dateFormat,
    this.locale,
    this.pickerMode,
    this.pickerTheme,
    this.onCancel,
    this.onChange,
    this.onConfirm,
    this.theme,
    this.barrierLabel,
    RouteSettings settings,
  }) : super(settings: settings);

  final DateTime minDateTime, maxDateTime, initialDateTime;
  final String dateFormat;
  final DateTimePickerLocale locale;
  final DateTimePickerMode pickerMode;
  final DateTimePickerTheme pickerTheme;
  final VoidCallback onCancel;
  final DateValueCallback onChange;
  final DateValueCallback onConfirm;

  final ThemeData theme;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 200);

  @override
  bool get barrierDismissible => true;

  @override
  final String barrierLabel;

  @override
  Color get barrierColor => Colors.black54;

  AnimationController _animationController;

  @override
  AnimationController createAnimationController() {
    assert(_animationController == null);
    _animationController =
        BottomSheet.createAnimationController(navigator.overlay);
    return _animationController;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    double height = pickerTheme.pickerHeight;
    if (pickerTheme.title != null || pickerTheme.showTitle) {
      height += pickerTheme.titleHeight;
    }

    Widget bottomSheet = MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: _DatePickerComponent(route: this, pickerHeight: height),
    );

    if (theme != null) {
      bottomSheet = Theme(data: theme, child: bottomSheet);
    }
    return bottomSheet;
  }
}

class _DatePickerComponent extends StatelessWidget {
  final _DatePickerRoute route;
  final double _pickerHeight;

  _DatePickerComponent({Key key, @required this.route, @required pickerHeight})
      : this._pickerHeight = pickerHeight;

  @override
  Widget build(BuildContext context) {
    Widget pickerWidget = DatePickerWidget(
      firstDate: route.minDateTime,
      lastDate: route.maxDateTime,
      initialDate: route.initialDateTime,
      dateFormat: route.dateFormat,
      locale: route.locale,
      pickerTheme: route.pickerTheme,
      onCancel: route.onCancel,
      onChange: route.onChange,
      onConfirm: route.onConfirm,
    );
    return GestureDetector(
      child: AnimatedBuilder(
        animation: route.animation,
        builder: (BuildContext context, Widget child) {
          return ClipRect(
            child: CustomSingleChildLayout(
              delegate: _BottomPickerLayout(route.animation.value,
                  contentHeight: _pickerHeight),
              child: pickerWidget,
            ),
          );
        },
      ),
    );
  }
}

class _BottomPickerLayout extends SingleChildLayoutDelegate {
  _BottomPickerLayout(this.progress, {this.contentHeight});

  final double progress;
  final double contentHeight;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints(
      minWidth: constraints.maxWidth,
      maxWidth: constraints.maxWidth,
      minHeight: 0.0,
      maxHeight: contentHeight,
    );
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    double height = size.height - childSize.height * progress;
    return Offset(0.0, height);
  }

  @override
  bool shouldRelayout(_BottomPickerLayout oldDelegate) {
    return progress != oldDelegate.progress;
  }
}
