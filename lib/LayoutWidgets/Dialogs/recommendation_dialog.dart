import 'package:bookifyapp/Design/constants.dart';
import 'package:bookifyapp/Design/size_constants.dart';
import 'package:bookifyapp/Enums/list_type.dart';
import 'package:bookifyapp/InfoToast.dart';
import 'package:bookifyapp/LayoutWidgets/Lists/vertical_book_list_search.dart';
import 'package:bookifyapp/LayoutWidgets/Profile/profile_info.dart';
import 'package:bookifyapp/Models/Lecture.dart';
import 'package:bookifyapp/Models/Recommendation.dart';
import 'package:bookifyapp/Models/User.dart';
import 'package:bookifyapp/Design/SizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bookifyapp/Models/Book.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:bookifyapp/Design/info_text.dart';

// ignore: must_be_immutable
class RecommendationDialog extends StatefulWidget {
  List<Recommendation> _recommendations;
  User sendToUser;
  ListType type;

  RecommendationDialog(
    this._recommendations, {
    this.type = ListType.received_recommendation_form,
    this.sendToUser,
  });

  @override
  _RecommendationDialog createState() => _RecommendationDialog();
}

class _RecommendationDialog extends State<RecommendationDialog> {
  static const double PADDING_FACTOR_7 = 1.7;

  Dialog alertDialog;
  double width;
  double height;
  ScrollController scrollController;
  List<Widget> widgets;
  Color _backgroundColor;
  List<Lecture> recommendationsAccepted;
  List<Book> keepingRecommendations;

  final TextEditingController inputController = TextEditingController();

  @override
  void initState() {
    super.initState();

    recommendationsAccepted = new List();
    keepingRecommendations = new List();
    scrollController = new ScrollController();
    _backgroundColor = kPrimaryDarkColor;

    widgets = new List();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void addOrDeleteRecommendation(Book recommendedBook, bool add) {
    if (add) {
      if (!recommendationsAccepted.contains(recommendedBook.toLecture())) {
        recommendationsAccepted.add(recommendedBook.toLecture());
        keepingRecommendations.add(recommendedBook);
      }
    } else {
      if (recommendationsAccepted.contains(recommendedBook.toLecture())) {
        recommendationsAccepted.remove(recommendedBook.toLecture());
        keepingRecommendations.remove(recommendedBook);
      }
    }
  }

  void onRecommendationsAccepted() {
    User user = Provider.of<User>(context, listen: false);
    setState(() {
      user.addListOfLecturesToLectureListByKey(
          recommendationsAccepted, RECOMMENDED_LIST);
      user.addListOfLecturesToLectureListByKey(
          recommendationsAccepted, PENDING_LIST);
      user.addNewRecommendationsReceived(
          Recommendation.getRecommendationListFromBook(
              keepingRecommendations, user));
    });
    InfoToast.showRecommendationsSavedCorrectly();
    onRecommendationCanceled();
  }

  void onRecommendationCanceled() {
    Navigator.pop(context);
  }

  _getReceivedRecommendationStack() {
    return Stack(
      children: <Widget>[
        Positioned(
            top: (CONTAINER_FACTOR_70 * SizeConfig.heightMultiplier), //70
            child: Container(
                width: width,
                height: height -
                    (CONTAINER_FACTOR_70 * SizeConfig.heightMultiplier), //70
                color: _backgroundColor,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: kThirdDarkColor,
                      size:
                          (PADDING_FACTOR_40 * SizeConfig.imageSizeMultiplier),
                    ),
                  ),
                ))),
        ProfileInfo(
          widget._recommendations[0].recommendedBy,
          nameColor: kThirdDarkColor,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(
            (PADDING_FACTOR_7 * SizeConfig.imageSizeMultiplier), //7
            (CONTAINER_FACTOR_170 * SizeConfig.heightMultiplier), //170
            (PADDING_FACTOR_7 * SizeConfig.imageSizeMultiplier), //7
            (PADDING_FACTOR_10 * SizeConfig.widthMultiplier), //10
          ),
          child: Container(
              color: kThirdDarkColor,
              height: (0.29 * SizeConfig.heightMultiplier), //2
              width: width),
        ),
        Positioned(
            top: (CONTAINER_FACTOR_150 * SizeConfig.heightMultiplier), //150
            left: (PADDING_FACTOR_7 * SizeConfig.imageSizeMultiplier), //7
            right: (PADDING_FACTOR_7 * SizeConfig.imageSizeMultiplier), //7
            child: Container(
              width: width,
              height: (TEXT_FACTOR_50 * SizeConfig.imageSizeMultiplier), //50
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  ("Just recommended you " +
                      widget._recommendations.length.toString() +
                      " books."),
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kThirdDarkColor,
                    fontSize:
                        (TEXT_FACTOR_20 * SizeConfig.heightMultiplier), //20
                  ),
                ),
              ),
            )),
        Positioned(
            top: (29.45 * SizeConfig.heightMultiplier), //180
            left: (PADDING_FACTOR_7 * SizeConfig.imageSizeMultiplier), //7
            right: (PADDING_FACTOR_7 * SizeConfig.imageSizeMultiplier), //7
            child: Container(
              width: width,
              height: (TEXT_FACTOR_50 * SizeConfig.imageSizeMultiplier), //50
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  ("Select the ones that you want to add to your Pending list!"),
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: kThirdDarkColor,
                      fontSize:
                          (TEXT_FACTOR_12 * SizeConfig.heightMultiplier), //12
                      fontStyle: FontStyle.italic),
                ),
              ),
            )),
        Padding(
            padding: EdgeInsets.fromLTRB(
                PADDING_FACTOR_0,
                (35.13 * SizeConfig.heightMultiplier), //240
                PADDING_FACTOR_0,
                PADDING_FACTOR_0),
            child: VerticalBookListSearch(
              Recommendation.getRecommendedBooksFromRecommendations(
                  widget._recommendations),
              ListType.received_recommendation_form,
              backgroundColor: kPrimaryLightColor,
              onAcceptButtonTapped: onRecommendationsAccepted,
              onCancelButtonTapped: onRecommendationCanceled,
              addOrRemoveBook: addOrDeleteRecommendation,
            ))
      ],
    );
  }

  _getSendRecommendationStack() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Positioned(
            top: (7.32 * SizeConfig.heightMultiplier), // 50
            left: (PADDING_FACTOR_10 * SizeConfig.widthMultiplier), //10
            child: Container(
              width: width,
              height: (23.42 * SizeConfig.heightMultiplier), //160
              color: _backgroundColor,
            )),
        Positioned(
          top: 0,
          child: Align(
            alignment: Alignment.center,
            child: Icon(
              Icons.card_giftcard,
              color: kThirdDarkColor,
              size: (CONTAINER_FACTOR_100 * SizeConfig.heightMultiplier), //100
            ),
          ),
        ),
        Positioned(
            top: (CONTAINER_FACTOR_100 * SizeConfig.heightMultiplier), //100
            left: (PADDING_FACTOR_10 * SizeConfig.widthMultiplier), //10
            right: (PADDING_FACTOR_10 * SizeConfig.widthMultiplier), //10
            child: Container(
              width: width,
              height: (12.16 * SizeConfig.imageSizeMultiplier), //50
              color: kPrimaryDarkColor,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  ("Recommendar " +
                      widget._recommendations.length.toString() +
                      " libros a " +
                      widget.sendToUser.name +
                      "?"),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kThirdDarkColor,
                    fontSize:
                        (PADDING_FACTOR_20 * SizeConfig.heightMultiplier), //20
                  ),
                ),
              ),
            )),
        Positioned(
          top: (CONTAINER_FACTOR_150 * SizeConfig.heightMultiplier), //150
          left: (PADDING_FACTOR_10 * SizeConfig.widthMultiplier), //10
          right: (PADDING_FACTOR_10 * SizeConfig.widthMultiplier), //10
          child: Row(
            children: <Widget>[
              Expanded(flex: 5, child: _getAcceptButton()),
              Expanded(flex: 5, child: _getCancelButton())
            ],
          ),
        )
      ],
    );
  }

  _getAcceptButton() {
    return FlatButton(
        child: Text(ACCEPT_OPTION,
            style: TextStyle(
              color: Colors.blue,
              fontSize: (TEXT_FACTOR_14 * SizeConfig.textMultiplier), //14
            )),
        onPressed: () async {
          Navigator.pop(context);
        });
  }

  _getCancelButton() {
    return FlatButton(
      child: Text(CANCEL_OPTION,
          style: TextStyle(
            color: Colors.red,
            fontSize: (TEXT_FACTOR_14 * SizeConfig.textMultiplier), //14
          )),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    alertDialog = new Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
            height: height,
            width: width,
            child: widget.type == ListType.received_recommendation_form
                ? _getReceivedRecommendationStack()
                : _getSendRecommendationStack()));

    return alertDialog;
  }
}
