import 'package:bookifyapp/Design/constants.dart';
import 'package:bookifyapp/Interfaces/RemoveCommentInterface.dart';
import 'package:bookifyapp/LayoutWidgets/BookWidgets/summary_text.dart';
import 'package:bookifyapp/LayoutWidgets/Profile/user_preview_card.dart';
import 'package:bookifyapp/Models/MainComment.dart';
import 'package:bookifyapp/Pages/CommentPage/comment_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

import '../../../SizeConfig.dart';

class MainCommentCard extends StatelessWidget implements RemoveCommentInterface {
  bool fromDialog;
  bool seeAllComments;
  String chapterTitle;
  int chapterNumber;
  int commentPosition;
  MainComment mainComment;
  Function(int) removeCommentFunction;
  int positionKey;

  MainCommentCard(
      this.mainComment,
      {
        this.fromDialog = false,
        this.seeAllComments = false,
        this.chapterTitle = "",
        this.chapterNumber = 0,
        this.removeCommentFunction,
        this.positionKey,
      });

  @override
  Widget build(BuildContext context) {
    if (fromDialog || seeAllComments) {
      return GestureDetector(
        onTap: (){
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) =>
              CommentPage(
                this.mainComment,
                subCommentsPage: true,
                chapterTitle: this.chapterTitle,
                chapterNumber: this.chapterNumber,
                inactiveAddCommentOption: this.seeAllComments,
              )
             ));
        },
        child: _getCard(),
      );
    } else {
      return _getCard();
    }
  }

  @override
  removeComment(int pos){
    removeCommentFunction(this.positionKey);
  }

  _getCard(){
    return Card(
        elevation: (2.43 * SizeConfig.widthMultiplier), //10
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              UserPreviewCard(
                  mainComment.author,
                  height: (7.32 * SizeConfig.heightMultiplier), // 50
                  fontSize: (3.64 * SizeConfig.widthMultiplier),//15
                  card: false,
                  fromDialog: fromDialog,
                  removeComment: removeComment
              ),

              SummaryTextWidget(
                text: mainComment.comment,
                backgroundColor: kPrimaryDarkColor,
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(
                    (3.64 * SizeConfig.widthMultiplier),//15
                    0,
                    (3.64 * SizeConfig.widthMultiplier),//15
                    0
                ),
                child: Container(
                    color: kPrimaryLightColor,
                    height: (0.081 * SizeConfig.heightMultiplier), //0.5
                    width: double.infinity
                ),
              ),

              Container(
                color: kPrimaryDarkColor,
                child:  Padding(
                  padding: EdgeInsets.fromLTRB(
                      (3.64 * SizeConfig.widthMultiplier),//15
                      0,
                      (3.64 * SizeConfig.widthMultiplier),//15
                      0
                  ),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        flex: 3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            LikeButton(
                              size: (4.39 * SizeConfig.heightMultiplier), //30
                              likeCount: mainComment.likes,
                              countBuilder: (int count, bool isLiked, String text) {
                                final ColorSwatch<int> color =
                                isLiked ? Colors.pinkAccent : Colors.grey;
                                Widget result;
                                if (count > 0) {
                                  result = Text(
                                    count >= 1000
                                        ? (count / 1000).toStringAsFixed(1) +
                                        'k'
                                        : text,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: color,
                                        fontSize: (2.05 * SizeConfig.textMultiplier), //14
                                    ),
                                  );
                                }
                                return result;
                              },
                            ),
                          ],
                        ),
                      ),

                      Flexible(
                        flex: 3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Align(
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.insert_comment,
                                color: Colors.grey,
                                size: (4.39 * SizeConfig.heightMultiplier), //30
                              ),
                            ),

                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                mainComment.answers.length.toString(), /*+ " respuestas",*/
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: (2.05 * SizeConfig.textMultiplier), //14
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Flexible(
                        flex: 3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[

                            Align(
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.share,
                                color: Colors.grey,
                                size: (4.39 * SizeConfig.heightMultiplier), //30
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(
                    (3.64 * SizeConfig.widthMultiplier),//15
                    0,
                    (3.64 * SizeConfig.widthMultiplier),//15
                    0
                ),
                child: Container(
                    color: kPrimaryLightColor,
                    height: (0.081 * SizeConfig.heightMultiplier), //0.5
                    width: double.infinity
                ),
              ),
            ],
          ),
        )
    );
  }
}

