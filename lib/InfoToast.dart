
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class InfoToast {

  static void showListCopiedCorrecltyToBookshelf(String listTitle){
    Fluttertoast.showToast(
        msg: listTitle + "books list was added correctly to your Bookshelf.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  static void showCommentRemovedCorrectly(bool comment){
    String commentText =  comment ? "Comment" : "Sub-comment";
    Fluttertoast.showToast(
        msg: commentText + " removed correctly.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  static void showFinishedCongratulationsMessage(String bookTitle){
    Fluttertoast.showToast(
        msg: "Congratulations you just finished: " + bookTitle + ".",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  static void showBookAddedCorrectlyToast(String bookTitle){
    Fluttertoast.showToast(
        msg: bookTitle + " correctly added to Reading page.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  static void showBookRemovedCorrectlyToast(String bookTitle){
    Fluttertoast.showToast(
        msg: bookTitle + " correctly removed to Reading page.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

}