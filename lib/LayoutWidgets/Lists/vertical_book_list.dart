import 'package:bookifyapp/LayoutWidgets/Cards/book_card_in_vertical_list.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:bookifyapp/Models/Book.dart';
import 'package:bookifyapp/Enums/button_type.dart';
import 'package:bookifyapp/LayoutWidgets/Lists/list_title.dart';


class VerticalBookList extends StatefulWidget {

  VerticalBookList(this.readingBooks, this.pendingBooks); // : super(key: key);

  final List<Book> readingBooks;
  final List<Book> pendingBooks;

  @override
  _VerticalBookList createState() => _VerticalBookList();
}

class _VerticalBookList extends State<VerticalBookList> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey, //Color.fromRGBO(58, 66, 86, 1.0),
      body: _makeBody(),
    );
  }

  _makeCard(int index, List<Book> books, ButtonType buttonType) {
    return BookCardInVerticalList(books[index], buttonType);
  }

  _makeBody() {
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: widget.readingBooks.length + widget.pendingBooks.length + 2,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return _makeHeader('Reading:');
          } else if (index <= widget.readingBooks.length) {
            return _makeCard(index - 1, widget.readingBooks, ButtonType.read);
          } else if (index == widget.readingBooks.length + 1) {
            return _makeHeader('Pending:');
          } else {
            return _makeCard(index - 2 - widget.readingBooks.length, widget.pendingBooks, ButtonType.read);
          }
        },
      ),
    );
  }

  _makeHeader(String title){
    double width = MediaQuery.of(context).size.width;
    return ListTitle(title);
  }
}