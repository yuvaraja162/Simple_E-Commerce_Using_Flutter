import 'package:flutter/material.dart';
import 'model/model.dart';
import 'homepage.dart';
import 'main.dart';

class productview extends StatefulWidget {
  const productview({Key? key}) : super(key: key);

  @override
  State<productview> createState() => _productviewState();
}

class _productviewState extends State<productview> {
  ProductModel? productModel;
  TextEditingController pricecontroller = TextEditingController();

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      if (ModalRoute.of(context)?.settings.arguments != null) {
        final Map arguments = ModalRoute.of(context)?.settings.arguments as Map;

        setState(() {
          productModel = arguments['data'];
        });
      }
    });

    // print(data.product_id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Product Details'),
        ),
        body: SingleChildScrollView(
          child: Center(
              child: Container(
            padding: EdgeInsets.only(top: 200),
            //  alignment: Alignment.center,
            child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.baseline,
                children: [
                  Text(
                    '${productModel?.p_name}',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text('\$${productModel?.p_cost}',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      height: 50.0,
                      width: 150.0,
                      child: TextFormField(
                        controller: pricecontroller,
                        decoration: const InputDecoration(
                          filled: true,
                          labelText: 'Quantity',
                          hintText: 'Quantity of Products',
                        ),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  FloatingActionButton.extended(
                      onPressed: () {
                        _showDialog(context);
                      },
                      label: Text('Buy Now')),
                ]),
          )),
        ));
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Your Purchase!"),
          content: Text(
              '${productModel!.toJson()},Your Quantity:${pricecontroller.text}'),
          actions: <Widget>[
            new FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (c) => HomePage()),
                    (route) => false);
              },
            ),
          ],
        );
      },
    );
  }
}
