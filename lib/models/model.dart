
/// All models should be serializable
abstract class Model {

  Map toJson();

  //factory fromJson(Map<String, dynamic> json);
}