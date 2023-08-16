import 'package:common/constant/url/common_url.dart';
import 'package:dependencies/http.dart';

class KategoriApiClient {
  Future<Response> getAllKategori(){
    const getUrl = "${CommonUrl.baseUrl}/kategori/all";
    return get(
      Uri.parse(getUrl)
    );
  }

  Future<Response> addNewKategori(String namaKategori){
    const postUrl = "${CommonUrl.baseUrl}/kategori/add";

    return post(
      Uri.parse(postUrl),
      body: {
        'nama' : namaKategori
      }
    );
  }
}