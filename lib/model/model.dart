// product name, id, cost, availability, details, category
List<ProductModel> productsFromJson(dynamic str) =>
    List<ProductModel>.from((str).map((x) => ProductModel.fromJson(x)));

class ProductModel {
  int? p_id;
  int? p_cost;
  int? p_availability;
  String? p_name;
  String? p_details;
  String? p_category;
  //String? p_image;
  ProductModel({
    this.p_name,
    this.p_id,
    this.p_cost,
    this.p_availability,
    // this.p_image,
    this.p_details,
    this.p_category,
  });

  ProductModel.fromJson(Map<dynamic, dynamic> json) {
    p_name = json['p_name'];
    p_id = json['p_id'];
    p_cost = json['p_cost'];
    p_availability = json['p_availability'];
    // p_image = json['p_image'];
    p_details = json['p_details'];
    p_category = json['p_category'];
    //print(p_image);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['p_name'] = p_name;
    data['p_id'] = p_id;
    data['p_cost'] = p_cost;
    // data['p_image'] = p_image;
    data['p_availability'] = p_availability;
    data['p_details'] = p_details;
    data['p_category'] = p_category;

    return data;
  }
}
