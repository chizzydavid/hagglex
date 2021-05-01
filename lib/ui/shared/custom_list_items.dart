import 'package:flutter/material.dart';
import 'package:hagglex/utils/assets.dart';


class HGListItem extends StatelessWidget {
  final Map<String, String> listItem;
  final bool isMarketItem;

  HGListItem(this.listItem, {this.isMarketItem = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 17),
      width:  double.infinity,
      margin: EdgeInsets.only(bottom:10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: isMarketItem
          ? null
          : BorderRadius.all(Radius.circular(7)),
        border: isMarketItem 
          ? Border(bottom: BorderSide(width: 2.0, color: Color(0xffF3F3F3)),) 
          : null,

        boxShadow: isMarketItem 
          ? null
          : [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0.0, 2),
                blurRadius: 5,
                spreadRadius: 0.1
              ),
            ],
      ),
      
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: isMarketItem ? Color(0xffF2F2F2) : Color(0xffeae6ff),
            radius: 26,
            child: Image.asset(
              listItem['leading'],
              width: 38,
            ),
          ),
          SizedBox(width: 20,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  listItem['title'],
                  style: TextStyle(color: Color(0xff020202), fontSize: 17, fontWeight: isMarketItem ? FontWeight.normal : FontWeight.w500),
                ),
                SizedBox(height: 5),
                RichText(
                  text:  TextSpan(
                    text: listItem['subtitle'],
                    style: TextStyle(color: isMarketItem ? Color(0xffa6a6a6) : Color(0xff020202), fontSize: 13),
                    children: [
                      TextSpan(text: "  "),
                      if (isMarketItem) TextSpan(text: '+2.34%', style: TextStyle(color: Colors.green))
                    ]
                  ),
                ),
              ],
            ),
          ),
          if (isMarketItem)
            Image.asset(
              listItem['trailing'],
              width: 60,
            )
        ],
      ),
    );
  }
}


class NewsItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      width:  double.infinity,
      margin: EdgeInsets.only(bottom: 20),
      
      child: Row(
        children: [
          Container(
            width: 50,
            height: 60,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(Assets.NEWS_IMAGE),
              ),
              borderRadius: BorderRadius.all(Radius.circular(7)),
            ),
          ),
          SizedBox(width: 20,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Blockchain Bites: BTC on Ethereum, DeFi’s latest stablecoin, the currency cold wars",
                  style: TextStyle(fontSize: 15),),
                Row(
                  children: [
                    Text('6hrs ago', style: TextStyle(color: Color(0xffa6a6a6), fontSize: 13),),
                    SizedBox(width: 30,),
                    RichText(
                      text:  TextSpan(
                        text: 'Category: ',
                        style: TextStyle(color: Color(0xffa6a6a6), fontSize: 13),
                        children: [
                          TextSpan(text: 'Defi', style: TextStyle(color: Color(0xff020202))),
                        ]
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

