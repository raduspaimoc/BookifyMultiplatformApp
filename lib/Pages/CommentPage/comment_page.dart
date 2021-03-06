import 'dart:async';
import 'package:bookifyapp/Design/constants.dart';
import 'package:bookifyapp/Design/info_text.dart';
import 'package:bookifyapp/Design/size_constants.dart';
import 'package:bookifyapp/Interfaces/RemoveCommentInterface.dart';
import 'package:bookifyapp/LayoutWidgets/Cards/Comment/main_comment_card.dart';
import 'package:bookifyapp/LayoutWidgets/Cards/Comment/sub_comment_card.dart';
import 'package:bookifyapp/Models/Book.dart';
import 'package:bookifyapp/Models/Chapter.dart';
import 'package:bookifyapp/Models/MainComment.dart';
import 'package:bookifyapp/Models/User.dart';
import 'package:bookifyapp/Pages/CommentPage/Components/add_comment_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:bookifyapp/Models/Comment.dart';
import 'package:provider/provider.dart';

import '../../InfoToast.dart';
import '../../Design/SizeConfig.dart';

// ignore: must_be_immutable
class CommentPage extends StatefulWidget {
  bool subCommentsPage;
  bool inactiveAddCommentOption;
  MainComment mainComment;
  String chapterTitle;
  int chapterNumber;
  Book book;
  bool showAllCommentsOfChapter;

  CommentPage(
    this.mainComment, {
    this.chapterNumber,
    this.subCommentsPage = true,
    this.inactiveAddCommentOption = false,
    this.chapterTitle = "",
    this.showAllCommentsOfChapter = false,
  });

  CommentPage.showingAllBookComments(
    this.book, {
    this.chapterNumber,
    this.subCommentsPage = true,
    this.chapterTitle = "",
    this.showAllCommentsOfChapter = false,
    this.inactiveAddCommentOption = false,
  });

  @override
  _CommentPage createState() => _CommentPage();
}

class _CommentPage extends State<CommentPage>
    implements RemoveCommentInterface {
  List<Widget> comments;
  List<SubCommentCard> subComments;
  MainCommentCard mainCommentCard;
  TextField textField;
  String newComment;
  ScrollController scrollController;
  User user;
  TextEditingController textEditingController;
  Color publishContainerColor;
  Color publishTextColor;

  _createCommentAndSubcommentsContent() {
    mainCommentCard = MainCommentCard(
      widget.mainComment,
      chapterTitle: widget.chapterTitle,
      chapterNumber: widget.chapterNumber,
      removeCommentFunction: removeComment,
      positionKey: 0,
      seeAllComments: widget.inactiveAddCommentOption,
    );
    comments.add(mainCommentCard);

    for (int i = 0; i < widget.mainComment.answers.length; i++) {
      Comment comment = widget.mainComment.answers[i];
      subComments.add(SubCommentCard(
        comment,
        textEditingController: this.textEditingController,
        removeCommentFunction: removeComment,
        positionKey: (i + 1),
      ));
    }
    comments.addAll(subComments);
  }

  _createChapterCommentsContent() {
    int position = 0;
    int chapterNumber = 0;
    Chapter chapter = widget.book.chapters[widget.chapterNumber];
    for (Comment comment in chapter.comments) {
      comments.add(MainCommentCard(
        comment,
        fromDialog: true,
        chapterTitle: chapter.title,
        chapterNumber: chapterNumber,
        removeCommentFunction: removeComment,
        positionKey: position,
        seeAllComments: widget.inactiveAddCommentOption,
      ));
      position += 1;
      chapterNumber += 1;
    }
  }

  _createBookCommentsContent() {
    int position = 0;
    int chapterNumber = 0;
    for (Chapter chapter in widget.book.chapters) {
      for (Comment comment in chapter.comments) {
        comments.add(MainCommentCard(
          comment,
          fromDialog: true,
          chapterTitle: chapter.title,
          chapterNumber: chapterNumber,
          removeCommentFunction: removeComment,
          positionKey: position,
          seeAllComments: widget.inactiveAddCommentOption,
        ));
        position += 1;
        chapterNumber += 1;
      }
    }
  }

  @override
  void initState() {
    scrollController = new ScrollController();
    textEditingController = new TextEditingController();
    comments = new List();
    subComments = new List();

    if (widget.mainComment != null) {
      if (widget.subCommentsPage) {
        _createCommentAndSubcommentsContent();
      }
    } else {
      if (widget.book != null) {
        if (widget.showAllCommentsOfChapter) {
          _createChapterCommentsContent();
        } else {
          _createBookCommentsContent();
        }
      } else {
        publishContainerColor = Colors.yellow[100];
        publishTextColor = Colors.grey[300];
      }
    }
    _getTextField();

    super.initState();
  }

  _getTextField() {
    textField = TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(
          (PADDING_FACTOR_5 * SizeConfig.widthMultiplier),
          (PADDING_FACTOR_0),
          (PADDING_FACTOR_0),
          (PADDING_FACTOR_0),
        ),
        hintText: widget.subCommentsPage ? ADD_COMMENT : widget.chapterTitle,
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
      style: TextStyle(
        fontSize: (TEXT_FACTOR_14 * SizeConfig.textMultiplier),
        color: kThirdDarkColor, //14
      ),
      maxLines: null,
      expands: widget.subCommentsPage ? false : true,
      keyboardType: TextInputType.multiline,
      onChanged: (value) {
        newComment = value;
        if (!widget.subCommentsPage) {
          setState(() {
            publishContainerColor = Colors.yellow;
            publishTextColor = Colors.black;
          });
        }
      },
    );
  }

  _getSubcommentsListView() {
    return ListView.builder(
        controller: scrollController,
        shrinkWrap: true,
        padding: EdgeInsets.all(
            (PADDING_FACTOR_8 * SizeConfig.heightMultiplier)), //8
        itemCount: this.comments.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
              padding: EdgeInsets.fromLTRB(index != 0 ? 15 : 0, 0, 0, 0),
              child: this.comments[index]);
        });
  }

  _getColumnWithListViewAndAddCommentOption() {
    return Column(
      children: [
        Flexible(
          flex: 9,
          child: _getSubcommentsListView(),
        ),
        Flexible(
            flex: 0,
            child: Card(
              color: kPrimaryDarkColor,
              elevation: 10,
              child: Row(
                children: [
                  Flexible(
                    flex: 9,
                    child: textField,
                  ),
                  Flexible(
                      flex: 1,
                      child: GestureDetector(
                        child: Icon(
                          Icons.send,
                          color: kSecondaryDarkColor,
                          size: (PADDING_FACTOR_30 *
                              SizeConfig.heightMultiplier), //30
                        ),
                        onTap: _addComment,
                      )),
                ],
              ),
            )),
      ],
    );
  }

  _getPageScaffold(scaffoldChild, appBarText) {
    return Scaffold(
      body: Container(
        color: kPrimaryDarkColor,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: scaffoldChild,
      ),
      appBar: AppBar(
          iconTheme: IconThemeData(
            color: kThirdDarkColor, //change your color here
          ),
          backgroundColor: kPrimaryDarkColor,
          title: appBarText),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.mainComment != null) {
      if (widget.subCommentsPage) {
        return _getPageScaffold(
            widget.inactiveAddCommentOption
                ? _getSubcommentsListView()
                : _getColumnWithListViewAndAddCommentOption(),
            Text(
              widget.subCommentsPage ? widget.chapterTitle : ADD_COMMENT,
              style: TextStyle(color: kThirdDarkColor),
            ));
      }
    } else {
      if (widget.book != null) {
        return _getPageScaffold(
            ListView.builder(
                controller: scrollController,
                shrinkWrap: true,
                padding: EdgeInsets.all(
                    (PADDING_FACTOR_8 * SizeConfig.heightMultiplier)), //8
                itemCount: this.comments.length,
                itemBuilder: (BuildContext context, int index) {
                  return this.comments[index];
                }),
            Text(
              (!widget.showAllCommentsOfChapter && widget.book != null)
                  ? widget.book.title
                  : widget.chapterTitle,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: kThirdDarkColor),
            ));
      } else {
        return _getPageScaffold(
            AddCommentLayout(this.textField, this.publishContainerColor,
                this.publishTextColor, this.newComment),
            Text(
              ADD_COMMENT_2,
              style: TextStyle(color: kThirdDarkColor),
            ));
      }
    }
  }

  void removeComment(int key) {
    if (key != 0) {
      setState(() {
        comments.removeAt(key);
        InfoToast.showCommentRemovedCorrectly(false);
      });
    }
  }

  _addComment() {
    FocusScope.of(context).requestFocus(FocusNode());
    var user = Provider.of<User>(context, listen: false);
    SubCommentCard subCommentCard = SubCommentCard(
      new Comment(user, newComment),
      removeCommentFunction: removeComment,
      positionKey: this.comments.length,
    );
    setState(() {
      this.comments.add(subCommentCard);
    });
    _scrollToLastPosition();
  }

  _scrollToLastPosition() {
    Timer(
      Duration(seconds: 1),
      () => scrollController.jumpTo(scrollController.position.maxScrollExtent),
    );
  }
}
