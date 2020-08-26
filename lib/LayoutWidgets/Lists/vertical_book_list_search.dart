import 'package:bookifyapp/Enums/list_type.dart';
import 'package:bookifyapp/Models/Item.dart';
import 'package:bookifyapp/Models/Shop.dart';
import 'package:bookifyapp/Models/User.dart';
import 'package:bookifyapp/Pages/book_page.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:bookifyapp/Models/Book.dart';
import 'package:bookifyapp/LayoutWidgets/Lists/list_title.dart';
import 'package:bookifyapp/Enums/button_type.dart';
import 'package:bookifyapp/LayoutWidgets/friends_preview.dart';
import 'package:provider/provider.dart';


class VerticalBookListSearch extends StatefulWidget {

  VerticalBookListSearch(this.books, this.type, {this.title}); // : super(key: key);

  final List<Book> books;
  final ListType type;
  final String title;
  /*final List<Book> readingBooks;
  final List<Book> pendingBooks;*/

  @override
  _VerticalBookListSearch createState() => _VerticalBookListSearch();
}

class _VerticalBookListSearch extends State<VerticalBookListSearch> {

  User user;
  String _chapter_title = "2048 personas han guardado este libro";

  @override
  void initState() {
    super.initState();
    user = Provider.of<User>(context, listen: false);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey, //Color.fromRGBO(58, 66, 86, 1.0),
      body: _makeBody(),
    );
  }

  _makeListTile(index) {
    if (widget.type == ListType.normal){
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
                                  child: GestureDetector(
                                    /*onTap: (){
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                          builder: (context) => BookPage("title", widget.books[index],
                                              _getBooks())));
                                    },*/
                                    child: Image.network(
                                      widget.books[index].picture,

                                    ),
                                  )
                                )
                            ),
                        ),
                      ),

                      Flexible(
                          flex: 1,
                          child: Center(
                            child: LinearPercentIndicator(
                              //width: //150.0,
                              lineHeight: 5.0,
                              percent: 0.5,
                              progressColor: Colors.lightGreen,
                            ),
                          )
                      )
                    ],
                  ),
                ),

                /*onTap: (){
                      Navigator.of(context)
                          .push(MaterialPageRoute(
                          builder: (context) => BookPage("title", widget.books[index],
                              _getBooks())));
                    },*/
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
                                  widget.books[index].title,
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
                                widget.books[index].author,
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
                                          _chapter_title.substring(0, 18) + "...",
                                          style: TextStyle( fontWeight: FontWeight.bold,),
                                          maxLines: 1,
                                        ),

                                        /*AutoSizeText(
                                        "+ 28",
                                        style: TextStyle(
                                          color: Colors.grey[500],
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 1,
                                        textAlign: TextAlign.left,
                                      ),*/
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
                          child: _getFloatingActionButton(widget.books[index]),
                        )
                    )
                ),
              ],
            ),
          )
      );

    } else if (widget.type == ListType.preview_friends){
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
                  child: _getFriendsPreview(index)
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
                                  widget.books[index].title,
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
                                widget.books[index].author,
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
                                          _chapter_title.substring(0, 18) + "...",
                                          style: TextStyle( fontWeight: FontWeight.bold,),
                                          maxLines: 1,
                                        ),

                                        /*AutoSizeText(
                                        "+ 28",
                                        style: TextStyle(
                                          color: Colors.grey[500],
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 1,
                                        textAlign: TextAlign.left,
                                      ),*/
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
                          child: _getFloatingActionButton(widget.books[index]),
                        )
                    )
                ),
              ],
            ),
          )
      );
    }
  }

  _getFloatingActionButton(Book book){

    bool isInPendingList = user.isInPendingList(book.toLecture());
    bool isInReadingList = user.isInReadingList(book.toLecture());

    IconData iconData;
    Color buttonColor;

    if( isInPendingList || isInReadingList){
      iconData = Icons.check;
      buttonColor = Colors.green;
    } else {
      iconData = Icons.add;
      buttonColor = Colors.blueGrey;
    }

    return FloatingActionButton(
      backgroundColor: Colors.white,
      child: Icon(
        iconData,
        color: buttonColor,
        size: 50,
      ),
      onPressed: (){

      },
    );
  }

  List<Book> _getBooks(){
    List<Book> books = new List();
    Shop shop1 = new Shop.withoutIds("Casa del Libro", "https://i.pinimg.com/280x280_RS/77/56/01/77560124a4abb4053f4f95c9153ef565.jpg");
    Shop shop2 = new Shop.withoutIds("Fnac", "https://upload.wikimedia.org/wikipedia/commons/2/2e/Fnac_Logo.svg");
    Shop shop3 = new Shop.withoutIds("El corte ingles", "https://pbs.twimg.com/profile_images/1214523397239115781/wuA5BVB4_400x400.jpg");
    Shop shop4 = new Shop.withoutIds("Taugus Books", "https://imagessl.casadellibro.com/t19/i/logo.png");
    Shop shop5 = new Shop.withoutIds("Me gusta leer", "https://tienda.megustaleer.com/img/tienda-megustaleer-logo-1585260247.jpg");

    List<Item> items = new List();
    items.add(new Item.withoutId(shop1, "https://www.casadellibro.com/libro-en-busca-del-chico-irrompible/9788408228059/11405104", 16.05, "€"));
    items.add(new Item.withoutId(shop2, "https://www.fnac.es/a7456973/En-busca-del-chico-irrompible#st=el+chico+irr&ct=En+todo+Fnac&t=p", 16.05, "€"));
    items.add(new Item.withoutId(shop3, "https://www.elcorteingles.es/libros/A35120735-en-busca-del-chico-irrompible-tapa-dura-9788408228059/", 16.05, "€"));
    items.add(new Item.withoutId(shop4, "https://www.tagusbooks.com/ebook-en-busca-del-chico-irrompible-ebook/9788408230663/11537354", 16.05, "€"));
    items.add(new Item.withoutId(shop5, "https://tienda.megustaleer.com/libros/2519-dulce-chico-indecente-9788490708248.html", 16.05, "€"));

    Map<String, List<Item>> shopItems = {
      'Tapa Blanda': items,
      'Tapa Dura' : items,
      'Tapa Ebook': items,
    };



    String description =
    """
    Engánchate al fenómenoValeria de @BetaCoqueta, una saga altamente divertida, emotiva y sensual.

    ¡Te vas a enamorar!
    
    Valeria es escritora de historias de amor.
    Valeria vive el amor de forma sublime.
    Valeria tiene tres amigas: Nerea, Carmen y Lola.
    Valeria vive en Madrid.
    Valeria ama a Adrián hasta que conoce a Víctor.
    Valeria necesita sincerarse consigo misma.
    Valeria llora, Valeria ríe, Valeria camina...
    Pero el sexo, el amor y los hombres no son objetivos fáciles.
    Valeria es especial.
    Como tú.
    
    En los zapatos de Valeria es el primer libro de la«Saga Valeria», la primera obra deElísabet Benavent, que inició su carrera literaria autopublicándose y que en poco tiempo conquistó a cientos de lectores y se situó en los primeros puestos de la lista de más vendidos de ficción.
    
    Posteriormente la autora, también conocida por sus fans como@BetaCoqueta, ha continuado cosechando grandes éxitos con la publicación de su«Saga Silvia», la trilogía«Mi elección», la bilogía«Horizonte Martina» y la novelaMi isla.
    """;
    /*"Engánchate al fenómenoValeria de @BetaCoqueta, una saga altamente divertida, emotiva y sensual.\n" &
    "¡Te vas a enamorar!\n" &
    "Valeria es escritora de historias de amor.\n"&
    "Valeria vive el amor de forma sublime.\n"&
    "Valeria tiene tres amigas: Nerea, Carmen y Lola.\n"&
    "Valeria vive en Madrid.\n"&
    "Valeria ama a Adrián hasta que conoce a Víctor.\n"&
    "Valeria necesita sincerarse consigo misma.\n"&
    "Valeria llora, Valeria ríe, Valeria camina...\n"&
    "Pero el sexo, el amor y los hombres no son objetivos fáciles.\n"&
    "Valeria es especial.\n"&
    "Como tú.\n\n"&
    "En los zapatos de Valeria es el primer libro de la«Saga Valeria», la primera obra deElísabet Benavent, que inició su carrera literaria autopublicándose y que en poco tiempo conquistó a cientos de lectores y se situó en los primeros puestos de la lista de más vendidos de ficción.\n"&
    "Posteriormente la autora, también conocida por sus fans como@BetaCoqueta, ha continuado cosechando grandes éxitos con la publicación de su«Saga Silvia», la trilogía«Mi elección», la bilogía«Horizonte Martina» y la novelaMi isla.";*/

    Book book1 = new Book.withSummary(
        "En los Zapatos de Valeria",
        "Elisabeth Benavent",
        "https://imagessl3.casadellibro.com/a/l/t0/73/9788490628973.jpg",
        description,
        "1",
        "1",
        shopItems);

    Book book2 = new Book.withSummary(
        "En busca del chico irrompible",
        "Coque Mesa",
        "https://imagessl9.casadellibro.com/a/l/t5/59/9788408228059.jpg",
        description,
        "2",
        "1",
        shopItems);

    Book book3 = new Book.withSummary(
        "Con el amor bastaba",
        "Maxim Huerta",
        "https://imagessl2.casadellibro.com/a/l/t5/92/9788408221692.jpg",
        description,
        "3",
        "1",
        shopItems);

    Book book4 = new Book.withSummary(
        "A próposito de nada",
        "Woody Allen",
        "https://imagessl0.casadellibro.com/a/l/t5/50/9788491819950.jpg",
        description,
        "4",
        "1",
        shopItems);

    books.add(book1);
    books.add(book2);
    books.add(book3);
    books.add(book4);
    return books;
  }

  _getFriendsPreview(int index){
    if(widget.books[index].friends_reading != null  &&
        widget.books[index].friends_reading.length > 0){

      return Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
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
                      child: GestureDetector(
                        onTap: (){
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                          builder: (context) => BookPage("title", widget.books[index],
                                              _getBooks())));
                                    },
                        child: Image.network(
                          widget.books[index].picture,

                        ),
                      )
                    )
                ) //Icon(Icons.autorenew, color: Colors.white),
            ),
          ),

          Positioned(
              child: Align(
                alignment: FractionalOffset.bottomLeft,
                child: FriendsPreview(widget.books[index].friends_reading),
              )
          ),
        ],
      );

    } else {
      return Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
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
                      widget.books[index].picture
                  ),
                )
            ) //Icon(Icons.autorenew, color: Colors.white),
        ),
      );
    }
  }

  _makeCard(int index) {
    return  Card(
      /*shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7.0),
      ),*/
      elevation: 10,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child:  Container(
        height: 160,
        decoration: BoxDecoration(
          color: Colors.blueGrey,
        ),
        child: _makeListTile(index),
      ),
    );
  }

  _makeBody() {
    if (widget.type == ListType.add_custom_list){
      return Stack(
        children: <Widget>[
          Container(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: widget.books.length + 1,
              itemBuilder: (BuildContext context, int index) {
                  if(index == 0)
                    return ListTitle(widget.title);
                  return _makeCard(index - 1);
              },
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.white,
              height: 50,
              width:  MediaQuery.of(context).size.width,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 5,
                    child: FlatButton(
                      child: Text(
                          "Accept",
                          style: TextStyle(color: Colors.blue,)
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: FlatButton(
                      child: Text(
                          "Cancel",
                          style: TextStyle(color: Colors.red,)
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      );
    } else {
      return Container(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: widget.books.length,
          itemBuilder: (BuildContext context, int index) {
            return _makeCard(index);
          },
        ),
      );
    }
  }
}