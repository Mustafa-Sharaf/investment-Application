import 'package:flutter/material.dart';
import 'package:investment_app/app_theme/app_theme.dart';


class FullHeader extends StatefulWidget {
  String HeaderText;
  FullHeader({required this.HeaderText});

  @override
  State<FullHeader> createState() => _FullHeaderState();
}

class _FullHeaderState extends State<FullHeader> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            clipBehavior: Clip.none,
            children: [
              CustomPaint(
                painter: HeaderPainter(),
                child: SizedBox(
                  width: size.width,
                  height: size.height / 5,
                  child: Center(
                    child: Text(
                      widget.HeaderText,
                      style: const TextStyle(
                        fontSize: 50,
                        color: Colors.white,
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: -110,
                child: Row(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      clipBehavior: Clip.antiAlias,
                      decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(1000)),
                      child: Image.asset('assets/LoginImage.png',
                        fit: BoxFit.cover,
                      ),

                    ),

                  ],

                ),
              ),
            ],
          ),
        ]

    );
  }
}



class HeaderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color =  AppColors.primaryColor;
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height-20);
    path.quadraticBezierTo(
        size.width /6, size.height + 140, size.width, size.height-30);
    path.lineTo(size.width, 0);
    path.close();
    return canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
