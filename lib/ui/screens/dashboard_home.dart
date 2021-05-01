import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hagglex/ui/shared/button.dart';
import 'package:hagglex/ui/shared/custom_list_items.dart';
import 'package:hagglex/utils/dummy_data.dart';

class DashboardHomeScreen extends StatefulWidget {

  @override
  _DashboardHome createState() => _DashboardHome();
}

class _DashboardHome extends State<DashboardHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
                color: Theme.of(context).primaryColor,
                child: Column(
                  children: <Widget>[
                    buildAppbar(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Total portfolio balance", style: TextStyle(color: Colors.white, fontSize: 14)),
                            SizedBox(height: 10,),
                            Text("\$****", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,  fontSize: 21)),
                          ],
                        ),
                        buildCurrencySwitch()
                      ],
                    ),
                  ],
                ),
              ),

              Container(
                height: 150,
                color: Color(0xffF3F3F3),
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 7),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    ...dashboardSlides.map((image) => Padding(
                      padding: const EdgeInsets.only(top: 10.0, right: 10),
                      child: Image.asset(image),
                    )).toList()
                  ]
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sectionHeading("Markets"),
                    ...marketItems.map((item) => HGListItem(item)).toList(),

                    sectionHeading("Do More with HaggleX"),
                    ...featureItems.map((item) => HGListItem(item, isMarketItem: false)).toList(),

                    sectionHeading("Trending Crypto News"),
                    ...List.generate(4, (i) => NewsItem()),

                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Button(
                        "LOG OUT",
                          isGradientBg: true,
                          onPressedAction: () async {
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.remove('token');
                            Navigator.pushNamedAndRemoveUntil(context, 'login', (Route<dynamic> route) => false);                      
                          } 
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    );
  }

  Widget buildAppbar() {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 50,
            width: 50,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.white),
              borderRadius: BorderRadius.circular(45.0),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35.0),
                color: Color(0xffE9BBFF),
              ),
              child: Center(child: Text("SV", style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),))
            )
          ),

          Text("HaggleX", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),

          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xff48327B),
                  borderRadius: BorderRadius.all(Radius.circular(30))
                ),
                child: IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.notifications),
                  onPressed: () {},
                ),
              ),
              Positioned(
                right: 0,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: Center(child: Text('5', style: TextStyle(color: Colors.white, fontSize: 12))),
              ),
              )
          ],)
        ],
      ),
    );
  }

  Widget sectionHeading(String heading) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, bottom: 20),
      child: Text(
        heading,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
      ),
    );
  }

  Widget buildCurrencySwitch() {
    return Container(
      padding: EdgeInsets.all(4),
      width:  120,
      height: 45,
      decoration: BoxDecoration(
        color: Color(0xfff8f8f8),
        borderRadius: BorderRadius.all(Radius.circular(22)),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            decoration: BoxDecoration(
              color: Color(0xffFFC175),
              borderRadius:  BorderRadius.all(Radius.circular(70)),
              border: Border.all(width: 2, color: Colors.white),
              boxShadow: [BoxShadow(
                color: Colors.black26,
                offset: Offset(0.0, 2),
                blurRadius: 5,
                spreadRadius: 0.1
              )]
            ),
            child: Center(child: Text("USD", style: TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.w500),)),
          ),
          Expanded(child: Center(child: Text("NGN", style: TextStyle(fontSize: 12, color: Colors.black45, ))))
        ],
      ),
    );
  }
}


