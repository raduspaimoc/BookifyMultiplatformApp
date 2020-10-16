import 'package:bookifyapp/Enums/book_card_type.dart';
import 'package:bookifyapp/Enums/button_type.dart';
import 'package:bookifyapp/Enums/list_type.dart';
import 'package:bookifyapp/Enums/profile_type.dart';
import 'package:bookifyapp/InfoToast.dart';
import 'package:bookifyapp/LayoutWidgets/Cards/book_card.dart';
import 'package:bookifyapp/LayoutWidgets/Cards/genre_card.dart';
import 'package:bookifyapp/LayoutWidgets/Cards/genre_container.dart';
import 'package:bookifyapp/LayoutWidgets/Cards/user_preview_card.dart';
import 'package:bookifyapp/LayoutWidgets/Dialogs/dialog_with_accept_and_cancel_options.dart';
import 'package:bookifyapp/LayoutWidgets/Dialogs/dialog_with_input_text.dart';
import 'package:bookifyapp/LayoutWidgets/Lists/list_title.dart';
import 'package:bookifyapp/Models/Genre.dart';
import 'package:bookifyapp/Pages/add_custom_list_page.dart';
import 'package:flutter/material.dart';
import 'package:bookifyapp/Models/User.dart';
import 'package:bookifyapp/Pages/profile_page.dart';
import 'package:provider/provider.dart';



class GenresGrid extends StatefulWidget {

  List<Genre> genres;

  GenresGrid(this.genres);

  @override
  _GenresGrid createState() => _GenresGrid();
}

class _GenresGrid extends State<GenresGrid> with TickerProviderStateMixin{

  bool showEditButton;

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    //ist<String> keys = widget.user.lectures.keys.toList();
    return GridView.count(
        key: UniqueKey(),
        //physics: NeverScrollableScrollPhysics(), // to disable GridView's scrolling
        shrinkWrap: true,
        crossAxisCount: 3,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        childAspectRatio:  (MediaQuery.of(context).size.width / 3) / (MediaQuery.of(context).size.height / 4),
        children: List.generate(widget.genres.length, (index) {
          return GenreContainer(widget.genres[index], width: (MediaQuery.of(context).size.width / 3) , height: (MediaQuery.of(context).size.height / 4),);
        })
    );
  }

}