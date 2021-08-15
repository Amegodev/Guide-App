import 'package:flutter/material.dart';
import 'package:prank_app/constants.dart';
import 'package:prank_app/utils/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class MoreApps extends StatefulWidget {
  @override
  _MoreAppsState createState() => _MoreAppsState();
}

class _MoreAppsState extends State<MoreApps> {
  List<FeaturedApp> _appsList = [];
  Widget _body = CircularProgressIndicator();

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.primary.withOpacity(0.8),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Featured Apps',
                      style: MyTextStyles.title
                          .apply(color: Palette.white, fontFamily: 'SuezOne'),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  IconButton(
                    onPressed: null,
                    icon: SizedBox(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: _appsList.length > 0 ? _buildBody() : Center(child: _body),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return RefreshIndicator(
      onRefresh: getData,
      child: ListView.builder(
        itemCount: _appsList.length,
        itemBuilder: (BuildContext ctx, index) {
          return InkWell(
            onTap: () async {
              String url = _appsList[index].url;
              try {
                await launch(url);
              } catch (e) {
                print('Could not launch $url, error: $e');
              }
            },
            child: Card(
              elevation: 8,
              color: Color(0XFF424444),
              child: Row(
                children: [
                  SizedBox(
                    height: 80.0,
                    width: 80.0,
                    child: ClipRRect(
                      child: Image.network(
                        _appsList[index].iconUrl,
                        height: 80.0,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Column(
                        children: [
                          Text(
                            _appsList[index].title,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow[600],
                                    size: 20.0,
                                  ),
                                  Text(_appsList[index].rating.toString(),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12.0,
                                      )),
                                ],
                              ),
                              Expanded(
                                child: Text(
                                  "${index + 1}# trending",
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.end,
                                ),
                              )
                            ],
                          ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> getData() async {
    setState(() {
      _body = CircularProgressIndicator();
    });
    if (Constants.featuredApps.toString().isNotEmpty) {
      setState(() {
        _appsList = List<FeaturedApp>.from(
            Constants.featuredApps.map((model) => FeaturedApp.fromJson(model)));
      });
      setState(() {});
    } else {
      setState(() {
        _body = Text('No Data');
      });
    }
  }
}

class FeaturedApp {
  String title;
  String url;
  String iconUrl;
  double rating;

  FeaturedApp({this.title, this.url, this.iconUrl, this.rating});

  factory FeaturedApp.fromJson(Map<String, dynamic> json) {
    return FeaturedApp(
      title: json["title"],
      url: json["url"],
      iconUrl: json["icon_url"],
      rating: double.parse(json["rating"].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": this.title,
      "url": this.url,
      "icon_url": this.iconUrl,
      "rating": this.rating,
    };
  }
//

}
