import 'package:flutter/material.dart';

import '../../featuers/feed/screens/feed_screen.dart';
import '../../featuers/post/screens/add_post_screeen.dart';

class Constants {
  static const logoPath = 'assets/images/logo.png';
  static const loginEmotePath = 'assets/images/mti-1-1.png';
  static const googlePath = 'assets/images/google.png';

  static const bannerDefault = 'https://0samaahmed.com/MTI_photos/bg-32A.png';
  static const avatarDefault = 'https://0samaahmed.com/MTI_photos/mti-1-1.png';
  static const Color cafeBrown = Color(0xff632B13);
  // static const bannerDefault =
  //     'https://thumbs.dreamstime.com/b/abstract-stained-pattern-rectangle-background-blue-sky-over-fiery-red-orange-color-modern-painting-art-watercolor-effe-texture-123047399.jpg';
  // static const avatarDefault =
  //     'https://external-preview.redd.it/5kh5OreeLd85QsqYO1Xz_4XSLYwZntfjqou-8fyBFoE.png?auto=webp&s=dbdabd04c399ce9c761ff899f5d38656d1de87c2';
  static const tabWidget = [
    FeedScreen(),
    AddPostScreen(),
  ];
  static const IconData up =
      IconData(0xe800, fontFamily: 'MyFlutterApp', fontPackage: null);
  static const IconData down =
      IconData(0xe801, fontFamily: 'MyFlutterApp', fontPackage: null);

  static const awardsPath = 'assets/images/awards';

  static const awards = {
    'awesomeAns': '${Constants.awardsPath}/awesomeanswer.png',
    'gold': '${Constants.awardsPath}/gold.png',
    'platinum': '${Constants.awardsPath}/platinum.png',
    'helpful': '${Constants.awardsPath}/helpful.png',
    'plusone': '${Constants.awardsPath}/plusone.png',
    'rocket': '${Constants.awardsPath}/rocket.png',
    'thankyou': '${Constants.awardsPath}/thankyou.png',
    'til': '${Constants.awardsPath}/til.png',
  };
}