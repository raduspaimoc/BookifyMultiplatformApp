
import 'package:bookifyapp/LayoutWidgets/BookWidgets/summary_text.dart';
import 'package:bookifyapp/LayoutWidgets/Cards/sub_comment_card.dart';
import 'package:bookifyapp/LayoutWidgets/Cards/user_preview_card.dart';
import 'package:bookifyapp/Models/User.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

import 'main_comment_card.dart';



class CommentCard extends StatefulWidget {
  @override
  _MyExpanableCardViewFlutterState createState() =>
      _MyExpanableCardViewFlutterState();
}

class _MyExpanableCardViewFlutterState
    extends State<CommentCard> {
  //controller for TextField
  final username_controller = TextEditingController();
  final password_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(  // <-- Provides ExpandableController to its children
      child: Column(
        children: [
          Expandable(           // <-- Driven by ExpandableController from ExpandableNotifier
            collapsed: ExpandableButton(  // <-- Expands when tapped on the cover photo
              child: MainCommentCard()//buildCoverPhoto(),
            ),
            expanded: Column(
                children: [
                  MainCommentCard(subComments: true,),//buildAllPhotos(),
                  /*ExpandableButton(       // <-- Collapses when tapped on
                    child: Text("Back"),
                  ),*/
                ]
            ),
          ),
        ],
      ),
    );
  }
}

/*class StarDisplay extends StatelessWidget {
  final int value;
  const StarDisplay({Key key, this.value = 0})
      : assert(value != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < value ? Icons.star : Icons.star_border,
        );
      }),
    );
  }
}*/

/*class CommentCard extends StatelessWidget {

  CommentCard();

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 10,
        //margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
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
            )


          ],
        )
    );
  }*/
//}