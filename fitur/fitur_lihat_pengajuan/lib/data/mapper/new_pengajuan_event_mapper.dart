class NewPengajuanEventMapper {
  int? parseData(String eventText){
    final data = eventText.trim().split('\n')[1];
    final splittedData = data.split(' ');

    return int.tryParse(splittedData[1]);
  }
}