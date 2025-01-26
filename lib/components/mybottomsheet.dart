import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:tech_news_app/utils/constants.dart';
import 'package:tech_news_app/utils/text.dart';

void url_launcher(String url)async{
  if(await canLaunchUrl(Uri.parse(url))){
    await launchUrl(Uri.parse(url));
  }else{
    throw "could not launch $url";
  }
}
void Mybottomsheet({required BuildContext context,required String title,required String imageurl,required String url,required String description}){
  showBottomSheet(
    context: context,
    // enableDrag: false,
    backgroundColor: Constants.bgcolor,
    elevation: 20,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))),
    builder: (context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height:  MediaQuery.sizeOf(context).height/2.2,
            child: Stack(
              children:[
                Container(
                  height: MediaQuery.sizeOf(context).height/2.4,
                  foregroundDecoration: BoxDecoration(
                    gradient: LinearGradient(colors: [Colors.black,Colors.transparent],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter
                    ),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                      image: DecorationImage(image: NetworkImage(imageurl),fit: BoxFit.cover)
                  ),
                ),
                Positioned(
                    bottom: MediaQuery.sizeOf(context).height/18,
                    left: 5,
                    right: MediaQuery.sizeOf(context).width/20,
                    child: Container(
                        child: boldtext(text: title, color: Constants.white, size: 20)))
              ]
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5,left: 5,right: 5),
            child: Modifiedtext(text: description, color: Constants.white, size: 18),
          ),
          TextButton(onPressed: (){
            if(url!=null){
              print(url);
              url_launcher(url);}

          },
              child: Text("Read More",style: TextStyle(color: Constants.primarycolor),))
        ],
      ),
    );
  },);
}