
import 'package:http/http.dart' as http;
import 'package:mysat/model/murid.dart';

class MuridService {
  static final String _baseUrl = 'http://192.168.0.103/my_store/getdata.php';
  Future getMurid() async {
    Uri urlApi = Uri.parse(_baseUrl);
    final response = await http.get(urlApi);
    if(response.statusCode ==200){
      return muridFromJson(response.body.toString());
    }else{
      throw Exception("Failed to load data");
    }
  }

  static final String _baseUrl2 = 'http://192.168.0.103/my_store/adddata.php';
  Future saveMurid(String item_code, String item_name, String price, String stock) async {
    Uri urlApi = Uri.parse(_baseUrl2);
    final response = await http.post(urlApi, body: ({
      "item_code" : item_code,
      "item_name" : item_name,
      "price" : price,
      "stock" : stock,

    }));
    if(response.statusCode ==200){
      print("Berhasil menyimpan data");
      //return muridFromJson(response.body.toString());
      return true;
    }else{
    print("gagal menyimpan data");
    return false;
      //throw Exception("Failed to load data");
    }
  }


}

