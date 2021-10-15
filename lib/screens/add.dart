import 'package:example/widgets/add_form.dart';
import 'package:flutter/material.dart';

class AddUserScreen extends StatefulWidget {
  AddUserScreen({Key? key}) : super(key: key);

  @override
  _AddUserScreenState createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _companyFocusNode = FocusNode();
  final FocusNode _ageFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          _nameFocusNode.unfocus();
          _companyFocusNode.unfocus();
          _ageFocusNode.unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('Añadir usuario'),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: AddUserForm(
                  nameFocusNode: _nameFocusNode,
                  companyFocusNode: _companyFocusNode,
                  ageFocusNode: _ageFocusNode),
            ),
          ),
        ));
  }
}
