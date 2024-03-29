import 'package:flutter/material.dart';
import 'package:honey_mobile/viewmodels/user.dart';
import 'package:honey_mobile/views/tabs/home-page.dart';
import 'package:honey_mobile/views/tabs/list-page.dart';
import 'package:honey_mobile/views/tabs/matching-page.dart';
import 'package:honey_mobile/views/tabs/random-matching.dart';
import 'package:honey_mobile/views/profile/profile.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    UserViewModel userViewModel = Provider.of<UserViewModel>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          leadingWidth: 100,
          leading: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              },
              child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          userViewModel.user!.show_medias![0]!.url),
                    ),
                  )),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                  icon: Image.asset(
                    'assets/images/bell.png',
                    height: 25,
                    width: 25,
                    color: Colors.grey,
                  ),
                  onPressed: () {}),
            ),
          ],
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/images/connect.png',
                    height: 25,
                    width: 25,
                    color: Theme.of(context).colorScheme.secondary),
                const SizedBox(width: 5),
                Text(
                  "Honey",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          )),
      body: PageView(
        onPageChanged: (page) {
          setState(() {
            _selectedIndex = page;
          });
        },
        controller: _pageController,
        children: const <Widget>[
          HomePage(),
          RandomMatchingPage(),
          ListPage(),
          MatchingPage(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.withAlpha(50),
              blurRadius: 5,
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed,
          onTap: _onTappedBar,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 5,
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/connect.png',
                height: 25,
                width: 25,
                color: _selectedIndex == 0
                    ? Theme.of(context).colorScheme.secondary
                    : Colors.grey,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/dice.png',
                height: 25,
                width: 25,
                color: _selectedIndex == 1
                    ? Theme.of(context).colorScheme.secondary
                    : Colors.grey,
              ),
              label: 'Random Matching',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/list.png',
                height: 25,
                width: 25,
                color: _selectedIndex == 2
                    ? Theme.of(context).colorScheme.secondary
                    : Colors.grey,
              ),
              label: 'Chat',
            ),
            BottomNavigationBarItem(
              icon: Stack(
                children: [
                  Image.asset(
                    'assets/images/chat.png',
                    height: 30,
                    width: 30,
                    color: _selectedIndex == 3
                        ? Theme.of(context).colorScheme.secondary
                        : Colors.grey,
                  ),
                  Positioned(
                    top: -1,
                    right: 0,
                    child: Container(
                        height: 8,
                        width: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).colorScheme.primary,
                        )),
                  )
                ],
              ),
              label: 'Chat',
            ),
          ],
        ),
      ),
    );
  }

  void _onTappedBar(int value) {
    setState(() {
      _selectedIndex = value;
    });
    _pageController.jumpToPage(value);
  }
}
