import 'package:flutter/material.dart';
import 'package:bookifyapp/Models/Book.dart';
import 'package:bookifyapp/Pages/book_page.dart';

class HorizontalBookList extends StatelessWidget {

  List<Book> books;
  BuildContext context;

  HorizontalBookList(this.books);

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Container(
      child: Card(
        color: Colors.blueGrey,
        child: _createListView(),
      ),
    );
  }


  _createListView(){
    return Container(
      height: 300,
      width: 500,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: books.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            margin: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7.0),
            ),
            elevation: 10,
            child: _getListElement(index),
          );
        },
      ),
    );
  }

  _getListElement(index){
    return Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
            child: Align(
              alignment: Alignment.center,
              child: InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => BookPage("title", books[index])));
                },
                child: Image.network(books[index].picture),
              ),
            ),
          ),

          Positioned(
            top: 6,
            right: 0,
            child: _getTopFloatingActionButton(),
          )
        ]
    );
  }

  _getTopFloatingActionButton(){
    return FloatingActionButton(
      onPressed: () => {

      },
      tooltip: 'Increment',
      backgroundColor: Colors.white,
      child: Icon(Icons.add, color: Colors.black),
    );
  }
}

