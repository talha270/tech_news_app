import 'package:flutter/material.dart';
import 'package:tech_news_app/utils/constants.dart';
import 'package:tech_news_app/utils/text.dart';

import '../backend/functions.dart';
import '../components/newsbox.dart';
import '../utils/apikey.dart';

class Detailpage extends StatefulWidget {
  const Detailpage({super.key, required this.imageurl, required this.news, required this.title});
  final String imageurl;
  final List news;
  final String title;
  @override
  State<Detailpage> createState() => _DetailpageState();
}

class _DetailpageState extends State<Detailpage> {
  int page = 1;
  final scrollController = ScrollController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent == scrollController.offset && !isLoading) {
        newPage();
      }
    });
  }

  newPage() async {
    setState(() {
      isLoading = true;
    });
    page++;
    List newNews = await fetchtypes("https://newsapi.org/v2/top-headlines?category=${widget.title}&apiKey=${Api.key}&pageSize=15&page=$page");
    if (newNews.isNotEmpty) {
      widget.news.addAll(newNews);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.bgcolor,
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: true,
            centerTitle: true,
            elevation: 20,
            backgroundColor: Constants.bgcolor,
            expandedHeight: MediaQuery.sizeOf(context).height / 2.2,
            flexibleSpace: FlexibleSpaceBar(
              title: Text("${widget.title} News", style: const TextStyle(color: Colors.white)),
              centerTitle: true,
              background: Image.network(widget.imageurl, fit: BoxFit.cover),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                if (index == widget.news.length) {
                  return isLoading
                      ? Center(child: CircularProgressIndicator(color: Constants.primarycolor))
                      : const SizedBox.shrink(); // Empty widget if not loading
                } else {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Newsbox(
                          title: widget.news[index]["title"] ?? "No Title Available",
                          discription: widget.news[index]["description"] ?? "No Description Available",
                          imageurl: widget.news[index]["urlToImage"] ?? widget.imageurl,
                          time: widget.news[index]["publishedAt"] ?? "No Date",
                          url: widget.news[index]["url"] ?? "",
                        ),
                      ),
                      Divider(color: Constants.darkgrey),
                    ],
                  );
                }
              },
              childCount: widget.news.length + 1,
            ),
          )
        ],
      ),
    );
  }
}
