import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'homepage.dart';

class EditProduct extends StatefulWidget {
  final Map product;

  EditProduct({@required this.product});

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _imageController = TextEditingController();

  Future updateProduct() async {
    print(widget.product["id"]);

    final response = await http.put(
        Uri.parse("http://192.168.1.13:80/api/product/" + widget.product["id"].toString()),
        body: {
          "name": _nameController.text,
          "description": _descriptionController.text,
          "price": _priceController.text,
          "image_url": _imageController.text
        });

    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Product"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController..text = widget.product["name"],
                  decoration: InputDecoration(labelText: "Name"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter product name";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _descriptionController..text = widget.product["description"],
                  decoration: InputDecoration(labelText: "Description"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter descriptions product";
                    }

                    return null;
                  },
                ),
                TextFormField(
                  controller: _priceController..text = widget.product["price"],
                  decoration: InputDecoration(labelText: "Price"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter price of product";
                    }

                    return null;
                  },
                ),
                TextFormField(
                  controller: _imageController..text = widget.product["image_url"],
                  decoration: InputDecoration(labelText: "Image URL"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter image url";
                    }

                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        updateProduct().then((value) {
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => HomePage()));
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text("Product updated")));
                        });
                      } else {}
                    },
                    child: Text('Update'))
              ],
            )),
      ),
    );
  }
}
