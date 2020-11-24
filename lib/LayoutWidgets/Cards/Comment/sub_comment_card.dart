import 'package:bookifyapp/Design/constants.dart';
import 'package:bookifyapp/Interfaces/RemoveCommentInterface.dart';
import 'package:bookifyapp/LayoutWidgets/BookWidgets/summary_text.dart';
import 'package:bookifyapp/LayoutWidgets/Profile/user_preview_card.dart';
import 'package:bookifyapp/Models/Comment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

import '../../../SizeConfig.dart';

class SubCommentCard extends StatelessWidget implements RemoveCommentInterface{

  Comment comment;
  TextEditingController textEditingController;
  Function(int) removeCommentFunction;
  int positionKey;


  SubCommentCard(this.comment, {
    this.textEditingController,
    this.removeCommentFunction,
    this.positionKey,
  });

  removeComment(int position){
    removeCommentFunction(this.positionKey);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          (2.43 * SizeConfig.widthMultiplier), //10
          0,
          0,
          0
      ),
      child: Card(
          elevation: (2.43 * SizeConfig.widthMultiplier), //10
          child: Column(
            children: <Widget>[
              UserPreviewCard(
                  this.comment.author,
                  height: (12.16 * SizeConfig.imageSizeMultiplier),//50
                  fontSize: (3.64 * SizeConfig.widthMultiplier),//15
                  card: false,
                  removeComment: removeComment
              ),

              SummaryTextWidget(
                text: this.comment.comment,
                backgroundColor: kPrimaryDarkColor,
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(
                    (3.64 * SizeConfig.widthMultiplier),//15
                    0,
                    (3.64 * SizeConfig.widthMultiplier),//15
                    0),
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
                      (1.21 * SizeConfig.widthMultiplier), //5
                      0,
                      (1.21 * SizeConfig.widthMultiplier), //5
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
                              likeCount: this.comment.likes,
                            ),
                          ],
                        ),
                      ),

                      Flexible(
                        flex: 3,
                        child: Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: (){
                              textEditingController.text = '@' + this.comment.author.name;
                            },
                            child: Text(
                              "Responder",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: (2.05 * SizeConfig.textMultiplier), //14
                              ),
                            ),
                          )
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }
}