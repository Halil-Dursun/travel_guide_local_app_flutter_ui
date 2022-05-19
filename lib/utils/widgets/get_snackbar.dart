

import 'package:flutter/material.dart';
import 'package:get/get.dart';

void getSnackbar({required String content,required String description, required Color color}) {
    Get.snackbar(
      content,
      description,
      backgroundColor: color,
      snackPosition: SnackPosition.BOTTOM,
      colorText: Colors.white,
    );
  }