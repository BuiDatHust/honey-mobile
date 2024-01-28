import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

abstract class ServiceHelper {
  void showMessage(
    GlobalKey<ScaffoldState>? scaffoldKey,
    Response<dynamic> errorModel,
  ) {
    if (scaffoldKey == null) return;

    if (scaffoldKey.currentContext == null) return;
    ScaffoldMessenger.of(scaffoldKey.currentContext!).showSnackBar(
      SnackBar(
          content: Text(
        errorModel.statusMessage ?? errorModel.statusCode.toString(),
      )),
    );
  }
}
