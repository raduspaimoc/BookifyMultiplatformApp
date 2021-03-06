import 'package:bookifyapp/Design/constants.dart';
import 'package:bookifyapp/Design/size_constants.dart';
import 'package:bookifyapp/Design/SizeConfig.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AddButtonSmall extends StatefulWidget {
  static IconData iconChecked = Icons.check;
  static IconData iconAdded = Icons.add;

  IconData _iconData;
  Function onButtonClicked;
  AddButtonSmall(this._iconData, {this.onButtonClicked});

  @override
  _AddButtonSmall createState() => _AddButtonSmall();
}

class _AddButtonSmall extends State<AddButtonSmall> {
  static const double HEIGHT_MULTIPLIER = 4.39;
  static const double WIDTH_MULTIPLIER = 7.29;
  static const double BORDER_MULTIPLIER = 1.7;
  static const double BORDER_WIDTH_MULTIPLIER = 0.24;

  IconData iconData;
  bool isInPendingList, isInReadingList;

  @override
  void initState() {
    super.initState();
    this.iconData = widget._iconData;
  }

  @override
  Widget build(BuildContext context) {
    return _getAddButton();
  }

  _getAddButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (iconData != AddButtonSmall.iconChecked) {
            iconData = AddButtonSmall.iconChecked;
            if (widget.onButtonClicked != null) {
              widget.onButtonClicked();
            }
          }
        });
      },
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Container(
          height: (HEIGHT_MULTIPLIER * SizeConfig.heightMultiplier), //30
          width: (WIDTH_MULTIPLIER * SizeConfig.widthMultiplier), //30
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(
                (BORDER_MULTIPLIER * SizeConfig.imageSizeMultiplier))), // 7
            border: Border.all(
                color: addButtonIconColor,
                width: (BORDER_WIDTH_MULTIPLIER * SizeConfig.widthMultiplier)),
            color: kPrimaryLightColor,
          ),
          child: Icon(iconData,
              size: (ICON_FACTOR_24 * SizeConfig.imageSizeMultiplier), //24
              color: addButtonIconColor),
        ),
      ),
    );
  }
}
