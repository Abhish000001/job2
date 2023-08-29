import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../constants.dart';
import '../chats/chats_screen.dart';
import '../edit_profile/edit_profile.dart';
import '../home_view/home_screen.dart';

class DashboardPageR extends StatefulWidget {
  const DashboardPageR({Key? key}) : super(key: key);

  @override
  State<DashboardPageR> createState() => _DashboardPageRState();
}

class _DashboardPageRState extends State<DashboardPageR> {
  int tabIndex = 0;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  onChangeTab(int index) {
    setState(() {
      tabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      // drawer: MainDrawer(),
      // appBar: getAppBar(),
      body: getBody(),
      bottomNavigationBar: getFooter(),
    );
  }

  Widget getBody() {
    return IndexedStack(
      index: tabIndex,
      children: [
        HomeScreenR(),
        ChatsScreenR(),
        Edit_profile(),

        //
      ],
    );
  }

  Widget getFooter() {
    return BottomNavigationBar(
        onTap: onChangeTab,
        currentIndex: tabIndex,
        backgroundColor: kSilverColor,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/images/home.svg"),
            activeIcon: SvgPicture.asset("assets/images/home_active.svg"),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/images/chat.svg"),
            activeIcon: SvgPicture.asset("assets/images/chat_active.svg"),
            label: "Message",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/images/account.svg"),
            activeIcon: SvgPicture.asset("assets/images/account_active.svg"),
            label: "Account",
          ),
        ]);
  }
}
