
import 'dart:async';
import 'dart:convert' as convert;
import 'dart:io';
import 'package:flutter/material.dart';

/// Base64 encode utils.
class Base64Utils {
  // Base64 encode
  static String base64Encode(String data){
    var content = convert.utf8.encode(data);
    var digest = convert.base64Encode(content);
    return digest;
  }

  // Base64 decode
  static String base64Decode(String data){
    List<int> bytes = convert.base64Decode(data);
    String result = convert.utf8.decode(bytes);
    return result;
  }

  // Convert image to base64 by path.
  static Future image2Base64(String path) async {
    File file = File(path);
    List<int> imageBytes = await file.readAsBytes();
    return convert.base64Encode(imageBytes);
  }

  // Convert image file to base64.
  static Future imageFile2Base64(File file) async {
    List<int> imageBytes = await file.readAsBytes();
    return convert.base64Encode(imageBytes);
  }

  // Decode to image from base64.
  static Future<Image> base642Image(String base64Txt) async {
    var decodeTxt = convert.base64.decode(base64Txt);
    return Image.memory(decodeTxt,
      width:100,fit: BoxFit.fitWidth,
      gaplessPlayback:true, //防止重绘
    );
  }

}