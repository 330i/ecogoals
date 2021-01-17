import 'package:ecogoals/api/api_client.dart';
import 'package:ecogoals/models/web_result.dart';
import 'package:ecogoals/pages/about_page.dart';
import 'package:ecogoals/pages/resources_page.dart';
import 'package:ecogoals/pages/video_page.dart';
import 'package:flutter/material.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';
import 'package:youtube_api/youtube_api.dart';

class Details extends StatefulWidget {
  final String item;
  final Map<String, dynamic> params;

  const Details({Key key, this.item, this.params}) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> with SingleTickerProviderStateMixin {
  TabController _tabController;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _pageController = PageController(initialPage: 0);
    getData();
  }

  List<WebResult> webresults = [];

  bool webloaded = false;
  bool fploaded = true;
  bool ytloaded = false;

  static String key = "AIzaSyAAcfo1cQeFevzRFgJzwkBvHesrclWIke8";
  YoutubeAPI ytApi = new YoutubeAPI(key);
  List<YT_API> ytResult = [];

  callYTAPI(String item) async {
    print('UI callled');
    ytResult = await ytApi.search("Eco-friendly " + item);
    setState(() {
      ytloaded = true;
      print('UI Updated');
    });
  }

  Future getData() async {
    print("STARTED");

    if (!webloaded)
      await fetchWebResult(widget.item).then((value) {
        setState(() {
          webresults = value;
          webloaded = true;
        });
      });

    if (!ytloaded) await callYTAPI(widget.item);
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
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut);
                },
                controller: _tabController,
                labelStyle: TextStyle(fontWeight: FontWeight.w700),
                indicatorSize: TabBarIndicatorSize.label,
                labelColor: Colors.lightGreen,
                unselectedLabelColor: Color(0xff5f6368),
                isScrollable: true,
                indicator: MD2Indicator(
                    indicatorHeight: 3,
                    indicatorColor: Colors.lightGreen,
                    indicatorSize: MD2IndicatorSize.full),
                tabs: [
                  Tab(
                    text: "About",
                  ),
                  Tab(
                    text: "Videos",
                  ),
                  Tab(
                    text: "Resources",
                  ),
                ],
              ),
            )),
      ),
      body: PageView(
        onPageChanged: (index) {
          _tabController.animateTo(index,
              duration: Duration(milliseconds: 300));
        },
        controller: _pageController,
        children: [
          fploaded
              ? About(
                  params: widget.params,
                )
              : Center(child: CircularProgressIndicator()),
          ytloaded
              ? VideosPage(
                  ytRes: ytResult,
                )
              : Center(child: CircularProgressIndicator()),
          webloaded
              ? ResourcesPage(
                  webresu: webresults,
                )
              : Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
