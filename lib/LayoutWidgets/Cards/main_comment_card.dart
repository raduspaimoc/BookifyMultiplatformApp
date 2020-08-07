import 'package:bookifyapp/LayoutWidgets/BookWidgets/summary_text.dart';
import 'package:bookifyapp/LayoutWidgets/Cards/sub_comment_card.dart';
import 'package:bookifyapp/LayoutWidgets/Cards/user_preview_card.dart';
import 'package:bookifyapp/Models/User.dart';
import 'package:bookifyapp/Pages/comment_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class MainCommentCard extends StatelessWidget {

  //bool subComments;
  bool fromDialog;
  //List<SubCommentCard> subCommentsList;
  //_MainCommentCard __mainCommentCard;

  MainCommentCard({
    this.fromDialog = false,
  });

  @override
  Widget build(BuildContext context) {
    if (fromDialog) {
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

              /*ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  itemCount: subCommentsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return subCommentsList[index];
                  }
              ),*/

              /*widget.subComments ? subCommentsListView : Padding(
                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Container(color: Colors.white, height: 0.5, width: double.infinity),
              ),*/

              //_getSubCommentsList(),


            ],
          ),
        )
    );
  }

  /*{
    __mainCommentCard = new _MainCommentCard(subCommentsList);
  }*/

  //_MainCommentCard __mainCommentCard = new _MainCommentCard(subCommentsList);

  /*@override
  _MainCommentCard createState() => __mainCommentCard;*/

  addSubComment(String comment){
    //__mainCommentCard.addSubComment(comment);
  }
}

class _MainCommentCard {


  ListView subCommentsListView;
  List<SubCommentCard> subCommentsList;

  _MainCommentCard(this.subCommentsList);

  _getCard(){
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

              ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  itemCount: subCommentsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return subCommentsList[index];
                  }
              ),

              /*widget.subComments ? subCommentsListView : Padding(
                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Container(color: Colors.white, height: 0.5, width: double.infinity),
              ),*/

              //_getSubCommentsList(),


            ],
          ),
        )
    );
  }

  addSubComment(String comment){
    SubCommentCard newComment = SubCommentCard(text: comment,);
    subCommentsList.add(newComment);

    /*setState(() {
      //subCommentsListView = _getSubCommentsContainer();
      subCommentsList.add(newComment);

    });*/
    //subCommentsListView = _getSubCommentsContainer();
    //print(comment);
  }

  _getSubCommentsContainer(){
    /*List<Widget> subCommentsColumn = new List();
    if(subCommentsList != null){
      subCommentsColumn.addAll(subCommentsList);
    }*/
    if(subCommentsList == null){
      subCommentsList = new List();
    }
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      itemCount: subCommentsList.length,
      itemBuilder: (BuildContext context, int index) {
        return subCommentsList[index];
      }
    );
    /*return Container(
      color: Colors.blueGrey,
      height: double.infinity,
      width: double.infinity,
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: subCommentsList.length,
        itemBuilder: (BuildContext context, int index) {
          return subCommentsList[index];
        }
      ),
    );*/
  }
}


