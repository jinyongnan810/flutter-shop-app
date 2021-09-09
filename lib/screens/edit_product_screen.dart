import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/product.dart';
import 'package:shop/providers/products.dart';
import 'package:shop/types/page_args.dart';

class EditProductScreen extends StatefulWidget {
  static final String routeName = '/products/edit';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  bool _isInitialized = false;
  bool _isLoading = false;
  final _priceFocusNode = FocusNode();
  final _descFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  Product _editingProduct =
      Product(id: '', title: '', description: '', price: 0, image: '');

  void _onImageUrlFocusEvent() {
    if (!_imageUrlFocusNode.hasFocus) {
      // makes rebuild ui
      setState(() {});
    }
  }

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_onImageUrlFocusEvent);
    super.initState();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_onImageUrlFocusEvent);
    // dispose focusNode to avoid memory leak
    _priceFocusNode.dispose();
    _descFocusNode.dispose();
    _imageUrlFocusNode.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context, listen: false);
    if (!this._isInitialized &&
        ModalRoute.of(context)!.settings.arguments != null) {
      // editing mode
      final args =
          ModalRoute.of(context)!.settings.arguments as EditUserProductArgs;
      final product = products.getSingleProduct(args.id);
      this._editingProduct = product;
      this._imageUrlController.text = product.image;
      this._isInitialized = true;
    }
    void onSubmit() async {
      if (!_form.currentState!.validate()) {
        return;
      }
      setState(() {
        _isLoading = true;
      });
      _form.currentState!.save();
      if (_editingProduct.id == '') {
        _editingProduct.id = Random().nextInt(100000).toString();
      }
      await products.saveProduct(_editingProduct);
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Edit Product'),
          actions: [
            IconButton(
                onPressed: () {
                  onSubmit();
                },
                icon: Icon(Icons.save))
          ],
        ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: EdgeInsets.all(8),
                child: Form(
                  key: _form,
                  autovalidateMode: AutovalidateMode.always,
                  // ListView will remove items not appearing on screen
                  // That when we use SingleChildScrollView&Column
                  child: SingleChildScrollView(
                      child: Column(
                    // child: ListView(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Title:'),
                        initialValue: _editingProduct.title,
                        // keyboard shows next
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter title.';
                          }
                          return null;
                        },
                        onFieldSubmitted: (_) {
                          // press enter on computer
                          // or next icon on keyboard will make the focusNode to be focused
                          FocusScope.of(context).requestFocus(_priceFocusNode);
                        },
                        onSaved: (value) {
                          _editingProduct.title = value ?? '';
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Price:'),
                        initialValue: _editingProduct.price.toString(),
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        focusNode: _priceFocusNode,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Price.';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Please enter valid number';
                          }
                          if (double.parse(value) <= 0) {
                            return 'Please enter a positive number';
                          }
                          return null;
                        },
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_descFocusNode);
                        },
                        onSaved: (value) {
                          double? price =
                              value == null ? 0 : double.tryParse(value);
                          _editingProduct.price = price ?? 0;
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Description:'),
                        initialValue: _editingProduct.description,
                        maxLines: 3,
                        keyboardType: TextInputType.multiline,
                        // multiline allows enter, therefore can't use next
                        // textInputAction: TextInputAction.next,
                        focusNode: _descFocusNode,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter description.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _editingProduct.description = value ?? '';
                        },
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              width: 100,
                              height: 100,
                              margin: EdgeInsets.only(top: 8, right: 10),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: Colors.grey)),
                              child: _imageUrlController.text.isEmpty
                                  ? Text('Enter a URL')
                                  : FittedBox(
                                      child: Image.network(
                                          _imageUrlController.text),
                                      fit: BoxFit.contain)),
                          // TextFormField has infinite width, have to restrict its width in Row
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(labelText: 'Image:'),
                              keyboardType: TextInputType.url,
                              textInputAction: TextInputAction.done,
                              controller: _imageUrlController,
                              focusNode: _imageUrlFocusNode,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter image url.';
                                }
                                if (!['jpg', 'png']
                                    .any((end) => value.endsWith(end))) {
                                  return 'Please enter an image url';
                                }
                                return null;
                              },
                              onFieldSubmitted: (_) {
                                onSubmit();
                              },
                              onSaved: (value) {
                                _editingProduct.image = value ?? '';
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  )),
                ),
              ));
  }
}
