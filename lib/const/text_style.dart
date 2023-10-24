import 'package:flutter/material.dart';
import 'package:music_player/const/colors.dart';

const bold = "bold";
const regular = "regular";

ourStyle({family = regular, double? size = 14, color = blackColor}) {
  return TextStyle(
    fontSize: size,
    color: color,
    fontFamily: family,
  );
}
