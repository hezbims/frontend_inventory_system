
class NewPengajuanEventMapper {
  int parseData(String eventText){
    final data = eventText.trim().split(' ');
    return int.parse(data[1]);
  }
}