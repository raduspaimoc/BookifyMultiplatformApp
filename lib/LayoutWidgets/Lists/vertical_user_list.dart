import 'package:bookifyapp/Design/constants.dart';
import 'package:bookifyapp/Enums/profile_type.dart';
import 'package:bookifyapp/LayoutWidgets/Profile/user_preview_card.dart';
import 'package:bookifyapp/Design/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:bookifyapp/Models/User.dart';
import 'package:bookifyapp/Pages/ProfilePages/profile_page.dart';
import 'package:provider/provider.dart';
import 'package:bookifyapp/Design/size_constants.dart';

class VerticalUserList extends StatefulWidget {
  VerticalUserList(this.users);

  final List<User> users;

  @override
  _VerticalUserList createState() => _VerticalUserList();
}

class _VerticalUserList extends State<VerticalUserList>
    with TickerProviderStateMixin {
  static const double DEFAULT_FONT_SIZE_FACTOR = 3.8;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryDarkColor,
      body: _makeBody(),
    );
  }

  _makeCard(int index) {
    User user = Provider.of<User>(context, listen: false);
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProfilePage(
                    widget.users[index], ProfileType.friend_profile,
                    isFriend: user.isFriend(widget.users[index]))));
      },
      child: UserPreviewCard(
        widget.users[index],
        padding: (PADDING_FACTOR_5 * SizeConfig.widthMultiplier), //5
        fontSize: (DEFAULT_FONT_SIZE_FACTOR * SizeConfig.textMultiplier), //26
      ),
    );
  }

  _makeBody() {
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: widget.users.length,
        itemBuilder: (BuildContext context, int index) {
          return _makeCard(index);
        },
      ),
    );
  }
}
