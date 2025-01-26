import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tech_news_app/backend/functions.dart';
import 'package:tech_news_app/pages/homepage.dart';

import '../utils/constants.dart';
class Searchbar extends StatefulWidget {
  const Searchbar({super.key});
  static TextEditingController searchcontroller=TextEditingController(text: "");
  @override
  State<Searchbar> createState() => _SearchbarState();
}

class _SearchbarState extends State<Searchbar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 50,
            padding: const EdgeInsets.only(left: 20,bottom: 5,right: 10,top: 10),
            decoration: BoxDecoration(
            color: Constants.darkgrey,
              borderRadius: BorderRadius.circular(20)
            ),
            child: TextField(
              style: TextStyle(
                color: Constants.primarycolor, // Set the color you want for the text
                // fontSize: 16.0,    // Optional: Set the font size
              ),
              controller: Searchbar.searchcontroller,
              decoration: InputDecoration(
                hintText: "Search",
                hintStyle: GoogleFonts.lato(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 20),
                border: InputBorder.none
              ),
            ),
          ),
        ),
        const SizedBox(width: 10,),
        InkWell(
          onTap: (){
            FocusScope.of(context).unfocus();
            if(Searchbar.searchcontroller.text!=""){
              MyHomePage.isslider=false;
              MyHomePage.query=Searchbar.searchcontroller.text;
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyHomePage(),));
            }
          },
          child: Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              color: Constants.darkgrey,
              shape: BoxShape.circle,
            ),
            child: Center(child: Icon(Icons.search,color: Constants.white,)),
          ),
        )
      ],
    );
  }
}

