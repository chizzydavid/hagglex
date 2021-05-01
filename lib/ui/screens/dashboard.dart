import 'package:flutter/material.dart';
import 'package:hagglex/ui/screens/dashboard_home.dart';
import 'package:hagglex/ui/screens/other.dart';
import 'package:hagglex/ui/shared/nav_icon.dart';
import 'package:hagglex/utils/assets.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class DashboardScreen extends StatefulWidget {
  @override
  Dashboard createState() => Dashboard();
}

class Dashboard extends State<DashboardScreen> {
  int tabIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  final List<Widget> _tabItems = [
    DashboardHomeScreen(),
    WalletScreen(),
    ExchangeScreen(),
    CryptoSaveScreen(),
    MoreScreen(),
  ];

  onTabClick(index) {
    setState(() => tabIndex = index);  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: _tabItems[tabIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: HomeNavIcon(Assets.HOME, tabIndex == 0),
            label:'Home',
          ),
          BottomNavigationBarItem(
            icon: HomeNavIcon(Assets.WALLET, tabIndex == 1),
            label:'Wallet'
          ),
          BottomNavigationBarItem(
            icon: Container(
              margin: EdgeInsets.only(top: 15),
              child: Icon(MdiIcons.bitcoin,size: 32,)),
            label:''
          ),
          BottomNavigationBarItem(
            icon: HomeNavIcon(Assets.CRYPTO, tabIndex == 3),
            label:'Cryptosave',
          ),
          BottomNavigationBarItem(
            icon: HomeNavIcon(Assets.MORE_ICON, tabIndex == 4),
            label:'More'
          ),
        ],
        currentIndex: tabIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Color(0xffC4C4C4),
        onTap: onTabClick,
      )
    );
  }
}
