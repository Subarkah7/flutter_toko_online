import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'homepage.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();

  TextEditingController _descriptionController = TextEditingController();

  TextEditingController _priceController = TextEditingController();

  TextEditingController _imageController = TextEditingController();

  Future saveProduct() async {
    final response = await http.post(Uri.parse("http://192.168.1.13:80/api/product"), body: {
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
        title: Text("Add Product"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: "Name"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter product name";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: "Description"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter descriptions product";
                    }

                    return null;
                  },
                ),
                TextFormField(
                  controller: _priceController,
                  decoration: InputDecoration(labelText: "Price"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter price of product";
                    }

                    return null;
                  },
                ),
                TextFormField(
                  controller: _imageController,
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
                        saveProduct().then((value) {
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => HomePage()));
                        });
                      } else {}
                    },
                    child: Text('Save'))
              ],
            )),
      ),
    );
  }
}
