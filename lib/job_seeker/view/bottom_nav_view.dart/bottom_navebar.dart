import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';
import '../chats/chats_screen.dart';
import '../home_view/home_screen.dart';
import '../profile_view/profile_screen.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
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
        HomeScreen(),
        ChatsScreen(),
        Profile_details()
      
      ],
    );
  }

  // AppBar getAppBar() {
  //   return AppBar(
  //     title: Text('jobs',style: TextStyle(color: Colors.black,),),
  //     backgroundColor: Colors.white,
  //     elevation: 0,
  //     leading: IconButton(
  //         onPressed: () => _scaffoldKey.currentState!.openDrawer(),
  //         icon: Icon(
  //           Icons.sort,
  //           size: 35.0,
  //           color: Colors.black87,
  //         ),
  //       ),

  //   );
  // }

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
          // BottomNavigationBarItem(
          //   icon: SvgPicture.asset("assets/images/match.svg"),
          //   activeIcon: SvgPicture.asset("assets/images/match_active.svg"),
          //   label: "Match",
          // ),
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
