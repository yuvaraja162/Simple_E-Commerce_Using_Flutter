import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'model/model.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'dart:core';
import 'dart:io';
import 'package:flutter/services.dart' as root;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ProductModel> products = [];
  ProductModel? model;
  var selectedItem = null;
  static Future<List<ProductModel>?> getProducts() async {
    var data = [
      {
        "p_name": "Apple",
        "p_id": 1,
        "p_cost": 30,
        "p_availability": 1,
        "p_details": "Imported from Swiss",
        "p_category": "Premium"
      },
      {
        "p_name": "Mango",
        "p_id": 2,
        "p_cost": 50,
        "p_availability": 1,
        "p_details": "Farmed at Selam",
        "p_category": "Tamilnadu"
      },
      {
        "p_name": "Bananna",
        "p_id": 3,
        "p_cost": 5,
        "p_availability": 0,
      },
      {
        "p_name": "Orange",
        "p_id": 4,
        "p_cost": 25,
        "p_availability": 1,
        "p_details": "from Nagpur",
        "p_category": "Premium"
      }
    ];

    return productsFromJson(data);
  }

  //***************** */
/*
  //this code for External JSON FILE
  //change tha file name then we can use the JSON

  Future<List<List<ProductModel>>> getProducts() async {
    final jsondata = await root.rootBundle.loadString('json/');
    final list = json.decode(jsondata) as List<dynamic>;
    return list.map((e) => productsFromJson(e)).toList();
  }
*/

  late String value;

  @override
  void initState() {
    super.initState();
    var selectedItem = null;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("HomePage")),
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder(
              future: getProducts(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  List<ProductModel> data = snapshot.data;

                  return Column(
                    children: [
                      DropdownSearch<String>(
                        mode: Mode.MENU,
                        showSelectedItems: true,
                        items: ['Tamilnadu', 'Premium'],
                        dropdownSearchDecoration: InputDecoration(
                          labelText: "Category",
                          hintText: "Select your Category",
                        ),
                        onChanged: (val) {
                          String s = val.toString();
                          setState(() {
                            selectedItem = s;
                            print(selectedItem);
                          });
                        },
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(8.0),
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          print(selectedItem);
                          if (data[index].p_category != "") {
                            return GestureDetector(
                                onTap: () {
                                  print(data[index]);
                                  Navigator.of(context).pushNamed(
                                    '/addproduct',
                                    arguments: {
                                      'data': data[index],
                                    },
                                  );
                                },
                                child: Card(
                                  child: Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        // SizedBox(
                                        //     height: 50,
                                        //     width: 100,
                                        //     child: Image.network(
                                        //         '${data[index].p_image}')),
                                        Text('${data[index].p_name}',
                                            style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold)),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text('\$${data[index].p_cost}',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                ));
                          } else {
                            return Container();
                          }
                        },
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.0,
                          crossAxisSpacing: 0.0,
                          mainAxisSpacing: 5,
                          mainAxisExtent: 264,
                        ),
                      )
                    ],
                  );
                } else {
                  return Text("err");
                }
              }),
          SizedBox(height: 20.0),
          // FloatingActionButton.extended(
          //   onPressed: () {},
          //   label: Text('Submit'),
          //   icon: Icon(Icons.shopping_bag),
          // )
        ],
      )),
    );
  }
}
