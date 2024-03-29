import 'package:dbu_push/models/user.dart';
import 'package:dbu_push/screens/pages/home.dart';
import 'package:dbu_push/screens/pages/notfications.dart';
import 'package:dbu_push/screens/pages/private_channel.dart';
import 'package:dbu_push/screens/pages/public_channels.dart';
import 'package:dbu_push/utils/Theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// UserModel? currentUser;
class PageNavigator extends StatefulWidget {
  PageNavigator({Key? key, required this.authUser}) : super(key: key);
  UserModel? authUser;
  // String? authUserPhone;
  @override
  State<PageNavigator> createState() => _PageNavigatorState();
}

class _PageNavigatorState extends State<PageNavigator> {
  int pageIndex =1;
  PageController? pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: pageIndex);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColors.scaffoldColor,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ));
  }

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  onpageTap(int pageIndex) {
    pageController!.animateToPage(pageIndex,
        duration: Duration(microseconds: 200), curve: Curves.linearToEaseOut);
  }

  @override
  void dispose() {
    pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        onPageChanged: onPageChanged,
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Notifications(),
          Home(
            user: widget.authUser,
          ),
          PrivateChannels(),
          PublicChannels(),
        ],
      ),
      bottomNavigationBar: CupertinoTabBar(
        onTap: onpageTap,
        currentIndex: pageIndex,
        activeColor: AppColors.primaryColor,
        // height: 60,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications,
              size: 30.0,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 30.0,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.group_work,
              size: 30.0,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.podcasts,
              size: 30.0,
            ),
          ),
        ],
      ),
    );
  }
}