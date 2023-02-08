import 'package:flocdock/constants/images.dart';
import 'package:flutter/cupertino.dart';

class CustomImage extends StatelessWidget {
  final String image;
  final double height;
  final double width;
  final BoxFit fit;
  final String placeholder;
  CustomImage({required this.image, this.height=100, this.width=100, this.fit=BoxFit.cover, this.placeholder=Images.showProfile1});

  @override
  Widget build(BuildContext context) {
    return FadeInImage.assetNetwork(
      placeholder: Images.showProfile1, height: height, width: width, fit: fit,
      image: image,
      imageErrorBuilder: (c, o, s) => Image.asset(
        placeholder,
        height: height, width: width, fit: fit,
      ),
    );
  }
}
