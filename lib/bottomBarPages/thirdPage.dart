import 'package:flutter/material.dart';

import 'package:md2_tab_indicator/md2_tab_indicator.dart';



class Details extends StatefulWidget {
  final String item;

  const Details({Key key, this.item}) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();

}

class _DetailsState extends State<Details> with SingleTickerProviderStateMixin{
  TabController _tabController;
  PageController _pageController;

  @override
  void initState(){
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _pageController = PageController(initialPage: 0);
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(10),
            child: Flexible(
              child: TabBar(
                onTap: (index) {
                  _pageController.animateToPage(index,
                      duration: Duration(milliseconds: 300)
                      , curve: Curves.easeInOut);
                },
                controller: _tabController,
                labelStyle: TextStyle(
                    fontWeight: FontWeight.w700),
                indicatorSize: TabBarIndicatorSize.label,
                labelColor: Colors.lightGreen,
                unselectedLabelColor: Color(0xff5f6368),
                isScrollable: true,
                indicator: MD2Indicator(
                    indicatorHeight: 4,
                    indicatorColor: Colors.lightGreen,
                    indicatorSize: MD2IndicatorSize.full
                ),
                tabs: [
                  Tab( text: "About",),
                  Tab( text: "Videos",),
                  Tab( text: "Shop",),
                  Tab(text: "Resources",),
                ],
              ),
            )
        ),
      ),
      body: PageView(
        onPageChanged: (index) {
          _tabController.animateTo(index,
              duration: Duration(milliseconds: 300));
        },
        controller: _pageController,
        children: [

        ],
      ),
    );
  }

}