import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

ImageProvider getImageProvider(
  String url,
  // Modification : ajout de ce paramètre
  [ Map<String, dynamic>? customProperties ]
) {
  if (url.startsWith('http')) {
    // Modification : ajout de ce bloc if
    if (customProperties != null && 
        customProperties.containsKey('x-appwrite-jwt'))
    {
      final String jwt = customProperties['x-appwrite-jwt'].toString();

      final Map<String, String> headers =
        <String, String>{ 'x-appwrite-jwt': jwt }; 

      return CachedNetworkImageProvider(url, headers: headers);
    } else {
      // Modification : ajout du bloc else avec l'unique appel à
      // CachedNetworkImageProvider(url) du bloc if originel
      return CachedNetworkImageProvider(url);
    }
  } else if (url.startsWith('assets')) {
    return AssetImage(url);
  } else {
    return FileImage(
      File(url),
    );
  }
}