class CategoriesModel
{
  late bool state;
  CategoriesDataModel? data;
  CategoriesModel.fromJson(Map<String,dynamic> json)
  {
    state = json['status'];
    data = CategoriesDataModel.fromJson(json['data']);
  }
}
class CategoriesDataModel
{
  int? currentPage;
  List<DataModel> data =[];
  CategoriesDataModel.fromJson(Map<String,dynamic> json){
    currentPage = json['current_page'];
    json['data'].forEach((element){
      data.add(DataModel.fromJson(element));
    });
  }
}
class DataModel
{
   late int id;
   late String image;
   late String name;
  DataModel.fromJson(Map<String,dynamic> json)
  {
    id = json['id'];
    image = json['image'];
    name = json['name'];
  }
}