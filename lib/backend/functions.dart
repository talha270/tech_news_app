import 'dart:convert';
import'package:http/http.dart'as http;

import '../components/searchbar.dart';
import '../utils/apikey.dart';

Future<List> fetchnews(String query)async{
  final  response;

  if(query!=""){

    response=await http.get(Uri.parse("https://newsapi.org/v2/everything?q=${query}&apiKey=${Api.key}&pageSize=15"));

  }else{
    response=await http.get(Uri.parse("https://newsapi.org/v2/everything?q=tech&apiKey=${Api.key}&pageSize=15"));

    // response=await http.get(Uri.parse("https://newsdata.io/api/1/latest?size=10&image=1&category=technology&country=us&apikey=${Api.key}&q=tech"));
  }

  Map returnvalue=jsonDecode(response.body);
  // print(returnvalue["results"].runtimeType);
  return returnvalue["articles"];
}


Future<List> fetchtypes(String url)async{
  final  response;
  Searchbar.searchcontroller.clear();
  if(Searchbar.searchcontroller.text!=""){
    response=await http.get(Uri.parse(url));
  }else{
    response=await http.get(Uri.parse(url));
    // response=await http.get(Uri.parse("https://newsdata.io/api/1/latest?size=10&image=1&category=technology&country=us&apikey=${Api.key}&q=tech"));
  }

  Map returnvalue=jsonDecode(response.body);
  print(url);
  return returnvalue["articles"];
}