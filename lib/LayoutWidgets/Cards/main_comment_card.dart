import 'package:bookifyapp/LayoutWidgets/BookWidgets/summary_text.dart';
import 'package:bookifyapp/LayoutWidgets/Cards/sub_comment_card.dart';
import 'package:bookifyapp/LayoutWidgets/Cards/user_preview_card.dart';
import 'package:bookifyapp/Models/User.dart';
import 'package:bookifyapp/Pages/comment_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class MainCommentCard extends StatefulWidget {

  bool subComments;
  bool fromDialog;
  List<SubCommentCard> subCommentsList;

  MainCommentCard({
    this.subComments = false,
    this.fromDialog = false,
    this.subCommentsList = const []
    //this.subCommentsList = new List();
  });

  _MainCommentCard __mainCommentCard = new _MainCommentCard();

  @override
  _MainCommentCard createState() => __mainCommentCard;

  addSubComment(String comment){
    __mainCommentCard.addSubComment(comment);
  }
}

class _MainCommentCard extends State<MainCommentCard>{

  Container subCommentsContainer;

  @override
  Widget build(BuildContext context) {
    if (widget.fromDialog) {
      return GestureDetector(
        onTap: (){
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => CommentPage()));
        },
        child: _getCard(),
      );
    } else {
      return _getCard();
    }

  }

  _getCard(){

    if(widget.subComments) {
      subCommentsContainer = _getSubCommentsContainer();
    }

    return Card(
        elevation: 10,
        //margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              UserPreviewCard(new User(
                  "1",
                  "Bill Gates",
                  "\"Not as good as Steve Jobs\"",
                  null,
                  null,
                  21,
                  198,
                  345,
                  "https://avatars0.githubusercontent.com/u/35029261?s=460&u=c54ea4c26c7f0659c014f362e538d2927f567a4f&v=4"
              ), height: 50, fontSize: 15, card: false,
              ),

              SummaryTextWidget(
                text: "Me encantaron todos los libros de la saga. Una historia muy entretenida y que te hace sentir todo lo que le sucede a los personajes. Me encanta la forma en la que todo es muy real. Las buenas y malas decisiones de los personajes son completamente creibles. Se leen muy rápido y los recomiendo :)",
                backgroundColor: Colors.blueGrey,
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Container(color: Colors.white, height: 0.5, width: double.infinity),
              ),

              Container(
                color: Colors.blueGrey,
                child:  Padding(
                  padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        flex: 3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            LikeButton(
                              size: 30,
                              /*circleColor:
                          CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
                          bubblesColor: BubblesColor(
                            dotPrimaryColor: Color(0xff33b5e5),
                            dotSecondaryColor: Color(0xff0099cc),
                          ),*/
                              /*likeBuilder: (bool isLiked) {
                            return Icon(
                              Icons.home,
                              color: isLiked ? Colors.deepPurpleAccent : Colors.grey,
                              size: 30,
                            );
                          },*/
                              likeCount: 999,
                              /*countBuilder: (int count, bool isLiked, String text) {
                            var color = isLiked ? Colors.deepPurpleAccent : Colors.grey;
                            Widget result;
                            if (count == 0) {
                              result = Text(
                                "love",
                                style: TextStyle(color: color),
                              );
                            } else
                              result = Text(
                                text,
                                style: TextStyle(color: color),
                              );
                            return result;
                          },*/
                            ),
                            /*Align(
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.supervised_user_circle,
                            color: Colors.black,
                            size: 30,
                          ),
                        ),

                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "12 me gusta",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                            ),
                          ),
                        ),*/
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
                                size: 30,
                              ),
                            ),

                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                "12 respuestas",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10,
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
                                size: 30,
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
                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Container(color: Colors.white, height: 0.5, width: double.infinity),
              ),

              widget.subComments ? subCommentsContainer : Padding(
                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Container(color: Colors.white, height: 0.5, width: double.infinity),
              ),

              //_getSubCommentsList(),


            ],
          ),
        )
    );
  }

  addSubComment(String comment){
    SubCommentCard newComment = SubCommentCard(text: comment,);
    widget.subCommentsList.add(newComment);
    setState(() {
      subCommentsContainer = _getSubCommentsContainer();
    });
    print(comment);
  }

  _getSubCommentsContainer(){
    List<Widget> subCommentsColumn = new List();
    if(widget.subCommentsList != null){
      subCommentsColumn.addAll(widget.subCommentsList);
    }
    return Container(
      color: Colors.blueGrey,
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
        child: Column(
          children: subCommentsColumn,
        ),
      ),
    );
  }
}


