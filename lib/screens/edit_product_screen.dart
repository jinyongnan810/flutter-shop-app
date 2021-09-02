import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  static final String routeName = '/products/edit';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();

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
                  onFieldSubmitted: (_) {
                    // press enter on computer
                    // or next icon on keyboard will make the focusNode to be focused
                    FocusScope.of(context).requestFocus(_priceFocusNode);
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Price:'),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  focusNode: _priceFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_descFocusNode);
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Description:'),
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  // multiline allows enter, therefore can't use next
                  // textInputAction: TextInputAction.next,
                  focusNode: _descFocusNode,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        width: 100,
                        height: 100,
                        margin: EdgeInsets.only(top: 8, right: 10),
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey)),
                        child: _imageUrlController.text.isEmpty
                            ? Text('Enter a URL')
                            : FittedBox(
                                child: Image.network(_imageUrlController.text),
                                fit: BoxFit.contain)),
                    // TextFormField has infinite width, have to restrict its width in Row
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Image:'),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        controller: _imageUrlController,
                        focusNode: _imageUrlFocusNode,
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
