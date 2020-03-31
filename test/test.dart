import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => Padding(
  padding: const EdgeInsets.all(10.0),
  child: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CupertinoActivityIndicator(),
          SizedBox(
            width: 20.0,
          ),
          Text('正在加载...'),
        ],
      )),
);