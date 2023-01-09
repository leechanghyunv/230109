import 'dart:convert';
import 'package:http/http.dart' as http;
import 'SubwayData.dart';

class Services {

  String subwayName1 = '서울';
  Services({
    required this.subwayName1,
  });


   Future<List<RealtimeArrivalList>> GetInfo() async{
     String Url = 'http://swopenAPI.seoul.go.kr/api/subway/4c6f72784b627261http://swopenAPI.seoul.go.kr/api/subway/584245494862726139335578556d47/json/realtimeStationArrival/0/8/3735677166456d/json/realtimeStationArrival/0/8/${subwayName1}';

     try{
      final response = await http.get(Uri.parse(Url));
      if(response.statusCode == 200){
        print('Got a Data');
        final RowApi = subwayApiFromJson as List<RealtimeArrivalList>;
        /// 여기서 문제되는것 같음
        return RowApi;

      }else{
        print('Error occured');
        return <RealtimeArrivalList>[];
      }
    }catch(e){
      print('Error occured again ${subwayName1}');
      return <RealtimeArrivalList>[];
    }
  }


}
