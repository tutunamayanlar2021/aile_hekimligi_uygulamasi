import 'package:aile_hekimligi_uygulamasi/constants/color_constant.dart';
import 'package:aile_hekimligi_uygulamasi/constants/style_constant.dart';
import 'package:aile_hekimligi_uygulamasi/view/home/user_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../model/news_response.dart';
import '../../service/news_api.dart';

class NewsView extends StatefulWidget {
  const NewsView({super.key});

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    double displayHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserView(),
          Container(
            height: displayHeight / 15,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: displayWidth / 30),
            child: Text("Daily News", style: StyleConstants().sHeaderBrown),
          ),
          const SizedBox(
            height: 15,
          ),
          Divider(),
          getData(displayWidth),
        ],
      ),
    );
  }

  Widget getData(double displayWidth) => Expanded(
      child: FutureBuilder<List<Articles>?>(
          future: NewsApiServices().fetchNewsArticle(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              List<Articles> newsArticle = snapshot.data!;
              return ListView.builder(
                  //shrinkWrap: true,
                  //physics: const BouncingScrollPhysics(),
                  // scrollDirection: Axis.horizontal,
                  itemCount: newsArticle.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: ColorConstants.instance.blackSkin
                                    .withOpacity(0.8),
                                blurRadius: 0.1,
                                spreadRadius: 0.1,
                                offset: Offset(1, 5)),
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          minVerticalPadding: 6,
                          onTap: (() async {
                            if (await canLaunchUrlString(
                                newsArticle[index].url.toString())) {
                              await launchUrlString(
                                  snapshot.data![index].url.toString());
                            } else {
                              throw "could not launch ${snapshot.data![index].url}";
                            }
                          }),
                          title: Text(
                            newsArticle[index].title.toString(),
                          ),
                          subtitle: Text(
                            newsArticle[index].description.toString(),
                          ),
                          leading: newsArticle[index].urlToImage != null
                              ? Container(
                                  width: 100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          image: NetworkImage(snapshot
                                              .data![index].urlToImage
                                              .toString()))),
                                )
                              : null,
                        ),
                      ),
                    );
                  });
            }
          }));
}
