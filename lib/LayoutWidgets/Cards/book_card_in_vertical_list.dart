import 'package:bookifyapp/InfoToast.dart';
import 'package:bookifyapp/LayoutWidgets/Buttons/read_action_button.dart';
import 'package:bookifyapp/LayoutWidgets/Dialogs/add_feedback_dialog.dart';
import 'package:bookifyapp/LayoutWidgets/Dialogs/book_shops_dialog.dart';
import 'package:bookifyapp/Models/Lecture.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:bookifyapp/Models/Book.dart';
import 'package:bookifyapp/Enums/button_type.dart';
//import  'package:explode_view/explode_view.dart';
import 'package:bookifyapp/LayoutWidgets/Lists/list_title.dart';


class BookCardInVerticalList extends StatelessWidget {

  //String chapter_title = "Nombre capitulo";
  BuildContext context;
  ButtonType buttonType;
  Lecture book;
  Card card;

  BookCardInVerticalList(this.book, this.buttonType);

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Stack(
      children: [
        Card(
            elevation: 10,
            margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            child:  GestureDetector(
              onTap: () async {
                await showDialog(
                  context: context,
                  builder: (BuildContext context) => AddFeedbackDialog(this.book),
                ).whenComplete(() {
                  if(this.book.finished){
                    //InfoToast.showFinishedCongratulationsMessage("VERGGGGGAAAAAA");
                    /*card = Card(
                    elevation: 10,
                    margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                    child:  Container(
                      color: Colors.lightGreen,
                      //width: doub,
                    )
                );*/
                  }
                });
              },
              child: Container(
                height: 160,
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                ),
                child: _makeListTile(),
              ),
            )
        ),

        Visibility(
          visible: false,
          maintainSize: false,
          maintainAnimation: false,
          maintainState: false,
          child:  Card(
            elevation: 10,
            margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            child:  Container(
              height: 160,
              decoration: BoxDecoration(
                color: Colors.lightGreen,
              ),
              //child: _makeListTile(),
            ),
          ),
        ),

        //Container(color: Colors.lightGreen, height: 160,),
      ],
    );
  }

  _makeListTile()   {
    FloatingActionButton floatingActionButton = new FloatingActionButton(
      backgroundColor: Colors.white,
      child: Icon(
        Icons.beenhere,
        color: Colors.blueGrey,
        size: 50,
      ),
    );

    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:  BorderRadius.circular(7.0)
        ),//Color.fromRGBO(64, 75, 96, .9),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
          child: Row(
            children: <Widget>[
              Flexible(
                flex: 3,
                child: Column(
                  children: <Widget>[
                    Flexible(
                      flex: 9,
                      child: Container(
                          width: 90,
                          //padding: EdgeInsets.only(right: 12.0),
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          decoration: new BoxDecoration(
                              border: new Border(
                                  right: new BorderSide(width: 1.0, color: Colors.blueGrey),
                                  left: new BorderSide(width: .075, color: Colors.blueGrey),
                                  bottom: new BorderSide(width: .075, color: Colors.blueGrey),
                                  top: new BorderSide(width: .075, color: Colors.blueGrey)
                              )
                          ),

                          child: Container(
                              color: Colors.black,
                              height: 150,
                              width: double.infinity,
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: Image.network(
                                    book.picture
                                ),
                              )
                          ) //Icon(Icons.autorenew, color: Colors.white),
                      ),
                    ),

                    Flexible(
                        flex: 1,
                        child: Center(
                          child: LinearPercentIndicator(
                            lineHeight: 5.0,
                            percent: !this.book.finished ? this.book.progress : 1.0,
                            progressColor: !this.book.finished ? Colors.lightGreen : Colors.deepPurple,
                          ),
                        )
                    )
                  ],
                ),
              ),

              Flexible(
                flex: 5,
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Container(
                    //color: Colors.black,
                    height: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          flex: 2,
                          child: Center(
                            child: Container(
                              child: Text(
                                book.title,
                                style: TextStyle(
                                  //color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),

                        Flexible(
                          flex: 2,
                          child: Center(
                            child: Text(
                              book.author,
                              style: TextStyle(
                                color: Colors.grey[500],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),

                        Flexible(
                          flex: 4,
                          child:  Align(
                              alignment: Alignment.bottomCenter,
                              child: Wrap(
                                direction: Axis.horizontal,
                                alignment: WrapAlignment.center,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[

                                      Icon(
                                        Icons.bookmark,
                                        color: Colors.blueGrey,
                                        size: 20,
                                      ),

                                      AutoSizeText(
                                        this.book.current_chapter_title.substring(0, 15) + "...",
                                        style: TextStyle( fontWeight: FontWeight.bold,),
                                        maxLines: 1,
                                      ),

                                      Visibility(
                                        visible: this.book.currentChapter != this.book.chapters.length - 1,
                                        maintainSize: false,
                                        maintainAnimation: false,
                                        maintainState: false,
                                        child:  AutoSizeText(
                                          "+" + (this.book.chapters.length - this.book.currentChapter - 1).toString(),
                                          style: TextStyle(
                                            color: Colors.grey[500],
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 1,
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),

              Flexible(
                  flex: 2,
                  child: Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: 75,
                        width: 75,
                        child: floatingActionButton,


                        /*CircularPercentIndicator(
                          radius: 60.0,
                          lineWidth: 3.0,
                          percent: .5,
                          center: floatingActionButton,
                          progressColor: Colors.green,
                        ),*/


                        /*child: FloatingActionButton(
                          backgroundColor: Colors.white,
                          child: Icon(
                            buttonType == ButtonType.read ?
                            Icons.beenhere : Icons.arrow_drop_up,
                            color: Colors.blueGrey,
                            size: 50,
                          ),
                        ),*/
                      )
                  )
              ),
            ],
          ),
        )
    );
  }
}