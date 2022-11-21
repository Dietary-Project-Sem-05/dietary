class MealPlanModal {
  String? plan_name;
  Map breakfast;
  Map lunch;
  Map dinner;
  String? breakfastTitle;
  String? lunchTitle;
  String? dinnerTitle;

  int? id;
  final DateTime createdTime;


  MealPlanModal(
      this.id,
      this.plan_name,
      this.breakfast,
      this.lunch,
      this.dinner,
      this.createdTime){
    breakfastTitle = "${breakfast.keys.toList()[0]}${breakfast.keys.toList().length > 1?" with ${breakfast.keys.toList()[1]}":""}";
    lunchTitle = "${lunch.keys.toList()[0]}${lunch.keys.toList().length > 1?" with ${lunch.keys.toList()[1]}":""}";
    dinnerTitle = "${dinner.keys.toList()[0]}${dinner.keys.toList().length > 1?" with ${dinner.keys.toList()[1]}":""}";

  }

  static String fromJson(Map map){
    map.remove(null);
    String output = "$map";
    print(output);

    return output;
  }


  static Map<String, double> toJson(String string){
    print(string + "Hello");
    var dataSp = string.replaceAll("{", "").replaceAll("}", "").split(', ');
    print(dataSp);
    Map<String,double> mapData = Map();
    for (var element in dataSp) {
      mapData[element.split(':')[0]] = double.parse(element.split(':')[1]);
    }
  print(mapData);
    return mapData;
  }


}
