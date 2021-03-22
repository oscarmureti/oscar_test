import 'dart:io';

import 'package:flutter/material.dart';
import 'package:oscar_interview/models/constant.dart';
import 'package:oscar_interview/src/design.dart';
import 'package:oscar_interview/src/dictionary.dart';
import 'package:oscar_interview/src/registration.dart';
import 'package:oscar_interview/src/response.dart';
import 'package:oscar_interview/widgets/custom_alert_dialog.dart';

class MainActivity extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<MainActivity> {
  PageController _pageController;
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => exitDialog(context),
      child: Scaffold(
          body: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: _pageController,
            onPageChanged: onPageChanged,
            children: <Widget>[
              RegisterPage(),
              Design(),
              Response(),
              Dictionary()
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            fixedColor: kPrimaryColor,
            showSelectedLabels: true,
            showUnselectedLabels: false,
            onTap: navigationTapped,
            currentIndex: _page,
            items: [
              BottomNavigationBarItem(
                label: 'Info',
                icon: Icon(Icons.info),
              ),
              BottomNavigationBarItem(
                label: 'Design',
                icon: Icon(Icons.design_services),
              ),
              BottomNavigationBarItem(
                label: 'Response',
                icon: Icon(Icons.feedback),
              ),
              BottomNavigationBarItem(
                label: 'Dictionary.',
                icon: Icon(Icons.book),
              ),
            ],
          )),
    );
  }

  exitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => CustomAlertDialog(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 15),
              Text(
                'Oscar Test',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 25),
              Text(
                "Do you really want to exit?",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    height: 40,
                    width: 130,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Text(
                        "Yes",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      onPressed: () => exit(0),
                      color: kPrimaryColor,
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 130,
                    child: OutlineButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      borderSide:
                          BorderSide(color: Theme.of(context).accentColor),
                      child: Text(
                        "No",
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 16,
                        ),
                      ),
                      onPressed: () => Navigator.pop(context),
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }

  void navigationTapped(int page) {
    if (page == 2.0) {
      // Provider.of<FavoritesProvider>(context, listen: false).getFeed();
      _pageController.jumpToPage(page);
    } else {
      //Provider.of<HomeProvider>(context, listen: false).getFeeds();
      _pageController.jumpToPage(page);
    }
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }
}
