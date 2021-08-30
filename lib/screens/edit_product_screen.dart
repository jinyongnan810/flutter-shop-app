import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  static final String routeName = '/products/edit';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit Product'),
        ),
        body: Padding(
          padding: EdgeInsets.all(8),
          child: Form(
            // ListView will remove items not appearing on screen
            // That when we use SingleChildScrollView&Column
            child: SingleChildScrollView(
                child: Column(
              // child: ListView(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Title:'),
                  // keyboard shows next
                  textInputAction: TextInputAction.next,
                )
              ],
            )),
          ),
        ));
  }
}
