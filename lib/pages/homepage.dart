import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tech_news_app/backend/functions.dart';
import 'package:tech_news_app/utils/text.dart';

import '../components/newsbox.dart';
import '../components/searchbar.dart';
import '../utils/apikey.dart';
import '../utils/constants.dart';
import 'detailpage.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  static String query="";
  static bool isslider=true;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool listloading=false;
  int page=1;
  final scrollcontroller=ScrollController();
  List news=[];
  List businessnews=[];
  List entertainmentnews=[];
  List generalnews=[];
  List  healthnews=[];
  List  sciencenews=[];
  List  sportsnews=[];
  List  technologynews=[];
  List slideritem=[];
  bool isloading=true;
  fetchcategories()async{
    businessnews=await fetchtypes("${dotenv.env["sub_categories_url"]}?category=business&apiKey=${Api.key}&pageSize=15")??[];
    entertainmentnews=await fetchtypes("${dotenv.env["sub_categories_url"]}?category=entertainment&apiKey=${Api.key}&pageSize=15")??[];
    generalnews=await fetchtypes("${dotenv.env["sub_categories_url"]}?category=general&apiKey=${Api.key}&pageSize=15")??[];
    healthnews=await fetchtypes("${dotenv.env["sub_categories_url"]}?category=health&apiKey=${Api.key}&pageSize=15")??[];
    sciencenews=await fetchtypes("${dotenv.env["sub_categories_url"]}?category=science&apiKey=${Api.key}&pageSize=15")??[];
    sportsnews=await fetchtypes("${dotenv.env["sub_categories_url"]}?category=sports&apiKey=${Api.key}&pageSize=15")??[];
    technologynews=await fetchtypes("${dotenv.env["sub_categories_url"]}?category=technology&apiKey=${Api.key}&pageSize=15")??[];
    if(businessnews.isNotEmpty&&entertainmentnews.isNotEmpty&&generalnews.isNotEmpty&&healthnews.isNotEmpty&&technologynews.isNotEmpty){
      slideritem.add(businessnews[0]["urlToImage"] ?? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzjv9Yoa6CGeXObgmQkthUjYVW2OAdOl63Vw&s");
      slideritem.add(entertainmentnews[0]["urlToImage"] ?? "https://i.ytimg.com/vi/nOa26uxgIBg/maxresdefault.jpg");
      slideritem.add(generalnews[0]["urlToImage"] ?? "https://media.gettyimages.com/id/184625088/photo/breaking-news-headline.jpg?s=612x612&w=gi&k=20&c=zryqClA8n2YKqCNhohRgqCd6W0tRTF8FD-2_lbTRnzo=");
      slideritem.add(healthnews[0]["urlToImage"] ?? "https://thumbs.dreamstime.com/b/health-news-broadcast-tv-title-graphic-health-news-graphic-main-title-videos-images-background-seamless-looping-video-140535000.jpg");
      slideritem.add(sciencenews[0]["urlToImage"] ?? "https://i0.wp.com/www.sciencenews.org/wp-content/uploads/2023/11/110423_neutron_1000.jpg?resize=445%2C575&ssl=1");
      slideritem.add(sportsnews[0]["urlToImage"] ?? "https://images.sportsbrief.com/static/logo_twitter.png");
      slideritem.add(technologynews[0]["urlToImage"] ?? "https://i.pinimg.com/736x/1e/8b/87/1e8b872db12cef272a3f3c4a8f974a0f.jpg");
    }

    print(slideritem);
    }
  void fetchall()async{
    if(MyHomePage.isslider){
    await fetchcategories();
    }
    news= await fetchnews(MyHomePage.query)??[];
    MyHomePage.query="";
    isloading=false;
    setState(() {

    });
  }
  @override
  void initState() {
    super.initState();
      fetchall();
    print(news);
    scrollcontroller.addListener((){
      if(scrollcontroller.position.maxScrollExtent==scrollcontroller.offset){
        newpage();
      }
    });
  }
  newpage()async{
    setState(() {
      listloading=true;
    });
    List temp=[];
    page++;
    MyHomePage.query!=""? temp.addAll(await fetchtypes("${dotenv.env["base_url"]}?q=${MyHomePage.query}&apiKey=${dotenv.env["api_key"]}&pageSize=15&page=$page")):temp.addAll(await fetchtypes("${dotenv.env["base_url"]}?q=tech&apiKey=${dotenv.env["api_key"]}&pageSize=15&page=$page"));
    if(temp.isNotEmpty){
        news.addAll(temp);
    }else{
      listloading=false;
    }
    setState(() {

    });
  }
  Future<void>refresh()async{
    Searchbar.searchcontroller.clear();
    news.addAll(await fetchnews(MyHomePage.query));
    MyHomePage.isslider=true;
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyHomePage(),));
    // setState(() {
    //
    // });
  }
  @override
  void dispose() {
    scrollcontroller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var w =MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: Constants.bgcolor,
      appBar: AppBar(
        backgroundColor: Constants.bgcolor,
        title: Container(
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              boldtext(text: dotenv.env["app_name"].toString(),color: Constants.primarycolor,size: 30.0),
              Modifiedtext(text: "News", color: Constants.white, size: 20.0)
            ]
          ),
        ),
        centerTitle: true,
        elevation: 20,
      ),
      body:isloading?const Center(child: CircularProgressIndicator(),): Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 3,),
            const Searchbar(),
            const SizedBox(height: 10,),
            MyHomePage.isslider?Expanded(
              child: CarouselSlider.builder(itemCount:slideritem.length,
                  itemBuilder: (context, index, realIndex) {
                    return InkWell(
                      onTap: (){
                        List selectedNews;
                        String titlepass;
                        switch (index) {
                          case 0:
                            titlepass="business";
                            selectedNews = businessnews;
                            break;
                          case 1:
                            titlepass="entertainment";
                            selectedNews = entertainmentnews;
                            break;
                          case 2:
                            titlepass="general";
                            selectedNews = generalnews;
                            break;
                          case 3:
                            titlepass="health";
                            selectedNews = healthnews;
                            break;
                          case 4:
                            titlepass="science";
                            selectedNews = sciencenews;
                            break;
                          case 5:
                            titlepass="sports";
                            selectedNews = sportsnews;
                            break;
                          case 6:
                            titlepass="technology";
                            selectedNews = technologynews;
                            break;
                          default:
                            titlepass="";
                            selectedNews = [];
                        }
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Detailpage(imageurl: slideritem[index],news: selectedNews, title: titlepass,)
                          ,));
                        },
                      child: Container(
                        // height:MediaQuery.sizeOf(context).height/2,
                        decoration: BoxDecoration(
                            image: DecorationImage(image: NetworkImage(slideritem[index]),fit: BoxFit.cover,),
                            borderRadius: BorderRadius.circular(20)
                        ),
                      ),
                    );
                  },
                  options: CarouselOptions(
                      autoPlay: true,
                      height: MediaQuery.sizeOf(context).height/2,
                      aspectRatio: 16/12,
                      viewportFraction: 0.60,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      autoPlayAnimationDuration: const Duration(seconds: 2),
                      enlargeCenterPage: true,
                      pageSnapping: true
                  )),
            ):Container(),
            MyHomePage.isslider?boldtext(text: "Tech News", color: Constants.primarycolor, size: 30):boldtext(text: "${Searchbar.searchcontroller.text} News", color: Constants.primarycolor, size: 30),
            const SizedBox(height: 10,),
            Expanded(child: Container(
              width: w,
              child: RefreshIndicator(
                onRefresh: refresh,
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  controller: scrollcontroller,
                  itemCount: news.length+1,
                  itemBuilder: (context, index) {
                    if(index==news.length){
                      return Center(child:listloading? CircularProgressIndicator(color: Constants.primarycolor,):const SizedBox.shrink());
                    }else{
                      return news[index]["urlToImage"]!=null?Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Newsbox(
                                title: news[index]["title"] ?? "No Title Available",
                                discription: news[index]["description"] ?? "No Description Available",
                                imageurl: news[index]["urlToImage"] ?? Constants.noimage,
                                time: news[index]["publishedAt"] ?? "No Date",
                                url: news[index]["url"] ?? ""),
                          ),
                          Divider(color: Constants.darkgrey,)
                        ],
                      ):Container();

                    }
                  },),
              ),
              // child: FutureBuilder(future: fetchnews(), builder: (context, snapshot) {
              //   if(snapshot.hasData){
              //     print(snapshot.data!);
              //     return
              //   }else if(snapshot.hasError){
              //     return Text(snapshot.error.toString());
              //   }else{
              //     return Center(child: CircularProgressIndicator(color: Constants.primarycolor,),);
              //   }
              // },),
            ))
          ],
        ),
      ),
    );
   }
}

