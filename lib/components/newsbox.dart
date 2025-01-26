import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tech_news_app/utils/text.dart';

import '../utils/constants.dart';
import 'mybottomsheet.dart';

class Newsbox extends StatelessWidget{
  final String imageurl,title,discription,url,time;

  const Newsbox({super.key, required this.imageurl, required this.title, required this.discription, required this.url, required this.time});
  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.sizeOf(context).width;
    return InkWell(
      onTap: (){
        Mybottomsheet(context: context,description: discription,imageurl: imageurl,url: url,title: title);
      },
      child: SizedBox(
        width: w,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CachedNetworkImage(imageUrl: imageurl,
              imageBuilder: (context, imageProvider) => Container(
                // width: MediaQuery.sizeOf(context).width/10,
                // height: MediaQuery.sizeOf(context).height/10,
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  image: DecorationImage(image: imageProvider,fit: BoxFit.cover,),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
              ),
              placeholder: (context, url) => CircularProgressIndicator(color: Constants.primarycolor,),
              errorWidget: (context, url, error) =>  CachedNetworkImage(imageUrl: Constants.noimage,
                imageBuilder: (context, imageProvider) => Container(
                  // width: MediaQuery.sizeOf(context).width/10,
                  // height: MediaQuery.sizeOf(context).height/10,
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: imageProvider,fit: BoxFit.cover,),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                ),
                placeholder: (context, url) => CircularProgressIndicator(color: Constants.primarycolor,),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            const SizedBox(width: 10,),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Modifiedtext(text: title, color: Constants.lightwhite, size: 16),
                  const SizedBox(height: 5,),
                  Modifiedtext(text: time, color: Constants.white, size: 12)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}