import 'package:bookifyapp/Design/constants.dart';
import 'package:bookifyapp/Enums/button_type.dart';
import 'package:bookifyapp/Enums/list_type.dart';
import 'package:bookifyapp/LayoutWidgets/Buttons/small_button_underlined.dart';
import 'package:bookifyapp/Models/User.dart';
import 'package:bookifyapp/Pages/add_custom_list_page.dart';
import 'package:bookifyapp/Pages/bookshelf_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListTitle extends StatelessWidget{

  User user;
  bool withButton;
  final String title;
  double fontSize;
  ButtonType buttonType;
  //Function(String) goToPageFromParent;
  //Function(String) goToPageFromParent2;
  Function(ButtonType buttonType, BuildContext context, {String title}) onListTitleButtonTapped;

  ListTitle(
      this.title,
      {
        this.withButton = false,
        this.buttonType = ButtonType.view_all,
        this.user,
        //this.goToPageFromParent,
        //this.goToPageFromParent2,
        this.onListTitleButtonTapped,
        this.fontSize = 30
      });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double width = MediaQuery.of(context).size.width;
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(10, 10, 2, 0),
            child: withButton ? _getRowWithButton(context) : _getTitle(),
          ),

          Padding(
            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
            child: Container(color: kPrimaryLightColor, height: 2, width: width),
          ),
        ],
      ),
    );
  }

  _getTitle(){
    return Align(
      alignment: Alignment.topLeft,
      child:  Text(
        title,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: this.fontSize, fontWeight: FontWeight.bold, color: kPrimaryLightColor),
      ),
    );
  }

  _getRowWithButton(BuildContext context){
    return Row(
      children: [
        Flexible(
          flex: 8,
          child:  _getTitle(),
        ),

        Flexible(
          flex: 3,
          child:  Align(
            alignment: Alignment.bottomRight,
            child:  Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
              child: (this.buttonType == ButtonType.edit_list || this.buttonType == ButtonType.copy_list) ?
              _getEditListButton(context) : _getViewAllButton(context),
            )
          ),
        )
      ],
    );
  }

  _getViewAllButton(BuildContext context){
    var buttonText = buttonType == ButtonType.edit_genres_list ? "Edit" : "View All";
    return GestureDetector(
      onTap: () {
        onListTitleButtonTapped(this.buttonType, context);
      },
      child: SmallButtonUnderlined(buttonText)
    );
  }

  _getEditListButton(BuildContext context){
    if(buttonType == ButtonType.copy_list){
      return _getEditOrCopyButton(context);
    } else {
      return Row(
        children: [
          Flexible(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child:  _getEditOrCopyButton(context),
            ),
          ) ,

          Flexible(
            flex: 5,
            child: _getDeleteButton(context),
          )
        ],
      );
    }

  }

  _getDeleteButton(BuildContext context){
    return GestureDetector(
        onTap: () {
          onListTitleButtonTapped(ButtonType.delete_list, context, title: title);
          //this.goToPageFromParent2(title);
        },
        child: SmallButtonUnderlined("Delete", textColor: Colors.red,),
    );

  }

  _getEditOrCopyButton(BuildContext context){
    return GestureDetector(
        onTap: () async {
          onListTitleButtonTapped(buttonType, context, title: title);

          /*if(buttonType == ButtonType.view_all) {
            final result = await Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) =>
                AddCustomListPage(Provider
                    .of<User>(context, listen: false)
                    .bookshelf, title, ListType.edit_custom_list)));
          } else if (buttonType == ButtonType.edit_list || buttonType == ButtonType.copy_list) {
            this.goToPageFromParent(title);
          }*/
        },
        child: buttonType == ButtonType.edit_list ?
        SmallButtonUnderlined("Edit") : SmallButtonUnderlined("Copy")
    );
  }

  //getED
}