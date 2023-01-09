import 'dart:convert';
import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';
import 'Services.dart';
import 'SubwayData.dart';

class SubwayApi {
  SubwayApi({
    this.rowNum,
    this.selectedCount,
    this.totalCount,
    this.subwayId,
    this.updnLine,
    this.trainLineNm,
    this.subwayHeading,
    this.statnFid,
    this.statnTid,
    this.statnId,
    this.statnNm,
    this.ordkey,
    this.subwayList,
    this.statnList,
    this.barvlDt,
    this.btrainNo,
    this.bstatnId,
    this.bstatnNm,
    this.recptnDt,
    this.arvlMsg2,
    this.arvlMsg3,
    this.arvlCd,
  });

  int? rowNum;
  int? selectedCount;
  int? totalCount;
  int? subwayId;
  String? updnLine;
  String? trainLineNm;
  String? subwayHeading;
  int? statnFid;
  int? statnTid;
  int? statnId;
  String? statnNm;
  String? ordkey;
  String? subwayList;
  String? statnList;
  int? barvlDt;
  dynamic btrainNo;
  int? bstatnId;
  String? bstatnNm;
  DateTime? recptnDt;
  String? arvlMsg2;
  String? arvlMsg3;
  int? arvlCd;

  factory SubwayApi.fromJson(Map<String, dynamic> json) => SubwayApi(
    rowNum: json["rowNum"],
    selectedCount: json["selectedCount"],
    totalCount: json["totalCount"],
    subwayId: json["subwayId"],
    updnLine: json["updnLine"],
    trainLineNm: json["trainLineNm"],
    subwayHeading: json["subwayHeading"],
    statnFid: json["statnFid"],
    statnTid: json["statnTid"],
    statnId: json["statnId"],
    statnNm: json["statnNm"],
    ordkey: json["ordkey"],
    subwayList: json["subwayList"],
    statnList: json["statnList"],
    barvlDt: json["barvlDt"],
    btrainNo: json["btrainNo"],
    bstatnId: json["bstatnId"],
    bstatnNm: json["bstatnNm"],
    recptnDt: DateTime.parse(json["recptnDt"]),
    arvlMsg2: json["arvlMsg2"],
    arvlMsg3: json["arvlMsg3"],
    arvlCd: json["arvlCd"],
  );

  Map<String, dynamic> toJson() => {
    "rowNum": rowNum,
    "selectedCount": selectedCount,
    "totalCount": totalCount,
    "subwayId": subwayId,
    "updnLine": updnLine,
    "trainLineNm": trainLineNm,
    "subwayHeading": subwayHeading,
    "statnFid": statnFid,
    "statnTid": statnTid,
    "statnId": statnId,
    "statnNm": statnNm,
    "ordkey": ordkey,
    "subwayList": subwayList,
    "statnList": statnList,
    "barvlDt": barvlDt,
    "btrainNo": btrainNo,
    "bstatnId": bstatnId,
    "bstatnNm": bstatnNm,
    "recptnDt": recptnDt?.toIso8601String(),
    "arvlMsg2": arvlMsg2,
    "arvlMsg3": arvlMsg3,
    "arvlCd": arvlCd,
  };
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  String DataState = '';
  String Datatotal = '';
  String checkway = '';
  String subwayName = '서울';
  String subwayName1 = '';
  String LineList = '';
  String SetNumber = '1004';
  List<RealtimeArrivalList> RowApi = <RealtimeArrivalList>[];

  getJsonFromXMLUrl(String Url) async {
    final Xml2Json xml2json = Xml2Json();
    try{
      var response = await http.get(Uri.parse(Url));

      xml2json.parse(utf8.decode(response.bodyBytes));
      var jsonString = xml2json.toParker();
      var data = jsonDecode(jsonString);

      var data3= data['realtimeStationArrival']['RESULT']['message'];
      var data4= data['realtimeStationArrival']['RESULT']['status'];
      var data5= data['realtimeStationArrival']['row'][1]['arvlMsg2'];
      var data7= data['realtimeStationArrival']['row'][1]['trainLineNm'];

      setState(() {
        DataState = data3;
        Datatotal = data4;
        checkway = data5;
        LineList = data7;
      });
      return jsonDecode(jsonString);
    }catch(e){
      print('got error what would you do');
    }
  }

  @override
  void initState() {
    getJsonFromXMLUrl(
        'http://swopenAPI.seoul.go.kr/api/subway/4c6f72784b6272613735677166456d/xml/realtimeStationArrival/0/5/서울');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text('205줄에 data1을 출력해야함 '),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text('${subwayName} 오픈 API 체크 \n',style: TextStyle(fontSize: 20),),
                Text('${DataState}\n'),
                Text('Code State: ${Datatotal}\n'),
                Text('${checkway}'),
                Text('도착지방면2▸▶︎✉️'),
                Text('${LineList}}️'),
                SizedBox(height: 50,),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],

                  ),
                  width: 100,
                  child: TextField(
                    onSubmitted: (val){
                      setState(() {
                        subwayName = val;
                        print('목적지는 ${subwayName}');
                      });

                    },
                  ),
                ),
                TextButton(
                    onPressed: (){
                      print('눌렀어');
                      setState(() {
                        Services(subwayName1: subwayName).GetInfo().then((value) {
                          setState(() {
                            RowApi = value;
                            if (RowApi.isNotEmpty) {
                              final index =  RowApi.indexWhere((element) => element.subwayId == "1004");
                              var data1 = RowApi[index].arvlCd;
                              print('Subway ID is ......${data1}');
                            }
                          print('No instance');

                          });
                        });
                      });
                },
                    child: Text('\n 지하철 DATA FILTER',style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
