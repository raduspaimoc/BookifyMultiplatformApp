import 'package:auto_size_text/auto_size_text.dart';
import 'package:bookifyapp/Design/constants.dart';
import 'package:bookifyapp/Enums/button_type.dart';
import 'package:bookifyapp/Enums/list_type.dart';
import 'package:bookifyapp/LayoutWidgets/Cards/Book/option_card.dart';
import 'package:bookifyapp/LayoutWidgets/Dialogs/add_feedback_dialog.dart';
import 'package:bookifyapp/LayoutWidgets/Dialogs/recommendation_dialog.dart';
import 'package:bookifyapp/Models/Lecture.dart';
import 'package:bookifyapp/Models/Recommendation.dart';
import 'package:bookifyapp/Pages/BookPage/book_page.dart';
import 'package:bookifyapp/Pages/add_custom_list_page.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:bookifyapp/Models/Book.dart';
import 'package:bookifyapp/LayoutWidgets/Buttons/add_button_small.dart';
import 'package:bookifyapp/Enums/book_card_type.dart';
import 'package:bookifyapp/Pages/SearchPage/search_page.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:bookifyapp/Pages/bookshelf_page.dart';
import 'package:bookifyapp/LayoutWidgets/Dialogs/dialog_with_input_text.dart';
import 'package:bookifyapp/Models/User.dart';
import 'package:provider/provider.dart';

import '../../../InfoToast.dart';
import '../../../SizeConfig.dart';


class BookCard extends StatefulWidget {

  BuildContext context;
  BookCardType type;
  bool _visible;
  Lecture book;
  User user;

  TickerProvider tickerProvider;
  ButtonType buttonType;
  int position;

  BookCard(this.book, this.type, {this.user});

  BookCard.option(this.type, {this.user});
  BookCard.inVerticalList(this.book, this.type, this.user, this.buttonType, this.position, this.tickerProvider);

  hideTitles(){
    this._visible = false;
  }

  @override
  _BookCard createState() => _BookCard(this.book, this.type, user: this.user, buttonType: this.buttonType);
}

class _BookCard extends State<BookCard>{

  BuildContext context;
  ButtonType buttonType;
  Lecture book;
  Card card;
  bool showEndLectureFrame = false;
  double buttonSize; // = 50.0;
  Widget content;
  bool visible;
  int animationControllerDuration;
  Color buttonColor;

  // Rotation controller
  AnimationController animationController;
  Animation<double> animation;

  // Confetti controller
  ConfettiController confettiController;

  BookCardType type;
  //Lecture book;
  User user;

  _BookCard(this.book, this.type, {this.user, this.buttonType});

  @override
  Widget build(BuildContext context) {
    this.context = context;
    if(type == BookCardType.book_card_in_vertical_list && book.finished){
      setState(() {
        confettiController.play();
        animationController.forward();
      });
    }
    return _getCardWidget();
  }

  @override
  void initState() {
    if(type == BookCardType.book_card_in_vertical_list){
      _initializeWidgetsInVerticalList();
    }


    super.initState();
  }

  _initializeWidgetsInVerticalList(){
    buttonColor = kPrimaryDarkColor;
    buttonSize = (12.16 * SizeConfig.imageSizeMultiplier); //50

    animationControllerDuration = 1500;
    widget._visible = true;
    animationController = AnimationController(
        duration: Duration(milliseconds: animationControllerDuration),
        vsync: widget.tickerProvider
    );

    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.elasticIn,
    )..addStatusListener((status) async {
      if(status == AnimationStatus.completed){
        var user = Provider.of<User>(context, listen: false);
        user.increaseChapter(widget.book);
        setState(() {
          if(this.book.finished){
            buttonSize = (18.24 * SizeConfig.imageSizeMultiplier); // 75
            widget._visible = false;
            bookCompletedProcess();
          } else {
            this.buttonColor = kPrimaryDarkColor;
          }
        });
      }
    });

    confettiController = new ConfettiController(
      duration: new Duration(seconds: 2),
    );
  }

  void bookCompletedProcess(){
    //widget.changeLecturePositionContent(widget.position, widget.book);
    setState(() {
      var user = Provider.of<User>(context, listen: false);
      user.moveLectureFromReadingListToReadList(book);
      InfoToast.showFinishedCongratulationsMessage(widget.book.title);
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  _getCardWidget(){
    return this.type == BookCardType.book_card_in_vertical_list ?
    Card(
        elevation: (2.43 * SizeConfig.widthMultiplier), //10
        margin: new EdgeInsets.symmetric(
            horizontal: (2.43 * SizeConfig.widthMultiplier), //10
            vertical: (0.98 * SizeConfig.heightMultiplier) //
        ),
        child:  GestureDetector(
            key: UniqueKey(),
            onTap: () async {
              await showDialog(
                context: context,
                builder: (BuildContext context) => AddFeedbackDialog(this.book),
              );/*.whenComplete(() {
              if(this.book.finished){
                //animationController.forward();
                bookCompletedProcess();
              }
            });*/
            },
            child: ConfettiWidget(
              blastDirectionality: BlastDirectionality.explosive,
              confettiController: confettiController,
              particleDrag: 0.05,
              emissionFrequency: 0.05,
              numberOfParticles: 25,
              gravity: 0.05,
              shouldLoop: false,
              colors: [
                Colors.green,
                Colors.red,
                Colors.yellow,
                Colors.blue,
              ],
              child: Container(
                height: (26.18 * SizeConfig.heightMultiplier), // 160
                decoration: BoxDecoration(
                  color: kPrimaryDarkColor,
                ),
                child: _makeListTile(context),
              ),
            )
        )
    ) :

    Card(
      key: UniqueKey(),
      color: Colors.transparent,
      margin: EdgeInsets.all((2.43 * SizeConfig.imageSizeMultiplier)), // 10
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular((1.7 * SizeConfig.imageSizeMultiplier)),
      ),
      elevation: (2.43 * SizeConfig.imageSizeMultiplier), // 10
      child: (this.type == BookCardType.add_option ||
              this.type == BookCardType.without_add_option_and_progress_bar ||
              this.type == BookCardType.book_card_in_grid) ? Stack(children: _getStackWidgets()) : _getOptionCard()
    );
  }

  _getStackWidgets(){
    return <Widget>[
      _getStackTopPart(),
      _getStackBottomPart(),
    ];
  }

  _getStackBottomPart(){
    if(this.type == BookCardType.add_option) {
      return Positioned(
        top: 0,
        right: 0,
        child: AddButtonSmall(
          (this.user.isInPendingList(this.book.toLecture()) || this.user.isInReadingList(this.book.toLecture()))
              ? AddButtonSmall.iconChecked: AddButtonSmall.iconAdded,
          onButtonClicked: (){
            if(!this.user.isInReadingList(this.book.toLecture())){
              if(!this.user.isInPendingList(this.book.toLecture())){
                setState(() {
                  this.user.addLectureToPendingList(this.book.toLecture());
                  InfoToast.showBookAddedCorrectlyToast(widget.book.title);
                });
              }
            }
          },
        ),
      );
    } else if (this.type == BookCardType.without_add_option_and_progress_bar || this.type == BookCardType.book_card_in_grid) {
      return Positioned(
        bottom: (0.24 * SizeConfig.imageSizeMultiplier), // 1
        right: (0.24 * SizeConfig.imageSizeMultiplier),
        left: (0.24 * SizeConfig.imageSizeMultiplier),
        child: Center(
          child: LinearPercentIndicator(
            lineHeight: (0.73 * SizeConfig.heightMultiplier), // 5
            percent: !this.book.finished ? this.book.progress : 1.0,
            progressColor: !this.book.finished ? Colors.lightGreen : Colors.deepPurple,
          ),
        ),
      );
    }

  }

  _getStackTopPart(){
    if(this.type == BookCardType.book_card_in_grid){
      return  Padding(
        padding: EdgeInsets.all(0),
        child: Align(
          alignment: Alignment.center,
          child: InkWell(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => BookPage("title", this.book, _getBooks())));
            },
            child: Image.network(
              this.book.picture, fit: BoxFit.fill, height: (29.28 * SizeConfig.heightMultiplier),
            ),
          ),
        ),
      );
    } else if (this.type == BookCardType.add_option ||
               this.type == BookCardType.without_add_option ||
               this.type == BookCardType.without_add_option_and_progress_bar){
      return Padding(
        padding: EdgeInsets.all(0),
        child: Align(
          alignment: Alignment.center,
          child: InkWell(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => BookPage("title", this.book, _getBooks())));
            },
            child: Image.network(this.book.picture),
          ),
        ),
      );

  }
  }

  _getOptionCard(){
    return GestureDetector(
        onTap: () async {
          onOptionCardPressed();
        },
        child: OptionCard(this.type)
    );
  }

  onOptionCardPressed() async {
    if(this.type == BookCardType.disover){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SearchPage()),
      );
    } else if (this.type == BookCardType.view_all){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BookshelfPage(this.user)),
      );
    } else if (this.type == BookCardType.add_custom_list){
      var result = await showDialog(
        context: context,
        builder: (BuildContext context) => DialogWithInputText(
            'Add List Title:',
            'Add a custom list of books from your Bookshelf, and share it with your friends.\n\n',
            'List Title'
        ),
      );
      if(result != DialogWithInputText.CANCEL_TAP){
        await _pushAddCustomListPage(result);
      }
    } else if(this.type == BookCardType.recommend_book){
      _pushRecommendBooksPage();
    }

  }

  sendRecommendedBooks(List<Book> recommendedBooks) async {
    List<Recommendation> recommendations = new List();
    User recommender = Provider.of<User>(context, listen: false);
    for(Book book in recommendedBooks){
      recommendations.add(new Recommendation(recommender, book));
    }
    // show popup and on accept send it to user.
    await showDialog(
        context: context,
        builder: (BuildContext context) => RecommendationDialog(
            Recommendation.getMockRecommendation(), type: ListType.send_recommendation_form, sendToUser: this.user,),
    );
    /**
     * Missing
     * This part will be implemented in futher steps.
     * */
  }

  _pushRecommendBooksPage() async{
    await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) =>
        AddCustomListPage(
            this.user.bookshelf,
            "Recommendation",
            ListType.send_recommendation_form,
            sendRecommendedBooks: sendRecommendedBooks,
        )));
  }

  _pushAddCustomListPage(String listTitle) async {
    final result = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => AddCustomListPage(this.user.bookshelf, listTitle, ListType.add_custom_list)));
    if(result == 0){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BookshelfPage(Provider.of<User>(context, listen: false), scrollToLastPosition: true,)),
      );
      //Navigator.pop(context);
    }
  }

  _makeListTile(BuildContext context)   {
    FloatingActionButton floatingActionButton = new FloatingActionButton(
      heroTag: UniqueKey(),
      backgroundColor: kPrimaryLightColor,
      child: RotationTransition(
        turns: animation,
        child: Icon(
          Icons.beenhere,
          color: !this.book.finished ? buttonColor : Colors.lightGreen,
          size: !this.book.finished ? buttonSize : (18.24 * SizeConfig.imageSizeMultiplier), // 75
        ),
      ),
      onPressed: () {
        setState(() {
          buttonColor = Colors.lightGreen;
        });
        setState(() {
          animationController.forward();
        });
      },
    );

    return Container(
        decoration: BoxDecoration(
            color: kPrimaryLightColor,
            borderRadius:  BorderRadius.circular((1.7 * SizeConfig.imageSizeMultiplier)) //7
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: (1.21 * SizeConfig.widthMultiplier), //5
            vertical: (2.43 * SizeConfig.widthMultiplier), //10
          ),
          child: Row(
            children: <Widget>[
              Flexible(
                flex: 3,
                child: Column(
                  children: <Widget>[
                    Flexible(
                      flex: 9,
                      child: Container(
                          width: (21.89 * SizeConfig.widthMultiplier), //90
                          //padding: EdgeInsets.only(right: 12.0),
                          //padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          decoration: new BoxDecoration(
                              border: new Border(
                                  right: new BorderSide(width: 1.0, color: kPrimaryDarkColor),
                                  left: new BorderSide(width: .075, color: kPrimaryDarkColor),
                                  bottom: new BorderSide(width: .075, color: kPrimaryDarkColor),
                                  top: new BorderSide(width: .075, color: kPrimaryDarkColor)
                              )
                          ),

                          child: Container(
                              color: Colors.black,
                              height: (24.54 * SizeConfig.heightMultiplier), //150
                              width: double.infinity,
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: Image.network(
                                    book.picture
                                ),
                              )
                          )
                      ),
                    ),

                    Flexible(
                        flex: 1,
                        child: Center(
                          child: LinearPercentIndicator(
                            lineHeight: (0.81 * SizeConfig.heightMultiplier), //5
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
                  padding: EdgeInsets.all((1.75 * SizeConfig.heightMultiplier)), //12
                  child: Container(
                    //color: Colors.black,
                    height: (24.54 * SizeConfig.heightMultiplier), //150
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          flex: 2,
                          child: Center(
                            child: AnimatedOpacity(
                              // If the widget is visible, animate to 0.0 (invisible).
                              // If the widget is hidden, animate to 1.0 (fully visible).
                              opacity: !this.book.finished  ? 1.0 : 0.0,
                              duration: Duration(milliseconds: animationControllerDuration),
                              // The green box must be a child of the AnimatedOpacity widget.
                              child: Center(
                                child: Container(
                                  child: Text(
                                    book.title,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 2.05 * SizeConfig.textMultiplier //14
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        Flexible(
                          flex: 2,
                          child: AnimatedOpacity(
                            // If the widget is visible, animate to 0.0 (invisible).
                            // If the widget is hidden, animate to 1.0 (fully visible).
                            opacity: !this.book.finished   ? 1.0 : 0.0,
                            duration: Duration(milliseconds: animationControllerDuration),
                            // The green box must be a child of the AnimatedOpacity widget.
                            child: Center(
                              child: Text(
                                book.author,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: 2.05 * SizeConfig.textMultiplier //14
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),

                        Flexible(
                          flex: 4,
                          child:  Align(
                            alignment: Alignment.bottomCenter,
                            child: AnimatedOpacity(
                              // If the widget is visible, animate to 0.0 (invisible).
                              // If the widget is hidden, animate to 1.0 (fully visible).
                                opacity: !this.book.finished   ? 1.0 : 0.0,
                                duration: Duration(milliseconds: animationControllerDuration),
                                // The green box must be a child of the AnimatedOpacity widget.
                                child: Wrap(
                                  direction: Axis.horizontal,
                                  alignment: WrapAlignment.center,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[

                                        Flexible(
                                          flex: 2,
                                          child: Icon(
                                            Icons.bookmark,
                                            color: kPrimaryDarkColor,
                                            size: (2.92 * SizeConfig.heightMultiplier), //20
                                          ),
                                        ),

                                        Flexible(
                                          flex: 6,
                                          child: AutoSizeText(
                                            this.book.current_chapter_title,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: (2.05 * SizeConfig.textMultiplier) //14
                                            ),
                                            maxLines: 1,
                                          ),
                                        ),

                                        Flexible(
                                          flex: 2,
                                          child: Visibility(
                                            visible: this.book.currentChapter != this.book.chapters.length - 1,
                                            maintainSize: false,
                                            maintainAnimation: false,
                                            maintainState: false,
                                            child:  AutoSizeText(
                                              "+" + (this.book.chapters.length - this.book.currentChapter - 1).toString(),
                                              //overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.grey[500],
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: (2.05 * SizeConfig.textMultiplier) //14
                                              ),
                                              maxLines: 1,
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                )
                            ),
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
                          height: (18.24 * SizeConfig.imageSizeMultiplier), //75
                          width: (18.24 * SizeConfig.imageSizeMultiplier), //75
                          child: floatingActionButton
                      )
                  )
              ),
            ],
          ),
        )
    );
  }

  List<Book> _getBooks(){
    return Book.getAppMockBooks();
  }
}

