import 'package:flutter/material.dart';
import 'package:play/widgets/custom_app_bar.dart';

class ProfileCollectionPage extends StatefulWidget {
  @override
  _ProfileCollectionPageState createState() => _ProfileCollectionPageState();
}

class _ProfileCollectionPageState extends State<ProfileCollectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(pageTitle: '我的收藏'),
      body: Container()
    );
  }
}
