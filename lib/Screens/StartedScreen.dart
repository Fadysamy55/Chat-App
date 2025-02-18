import 'package:chat3/Screens/Login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Constans/Const.dart';
import '../Widgets/Custom_button.dart';

class  Startedscreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return     Scaffold(
    backgroundColor: kPrimaryColor,
    body:Center(
    child: Padding(
    padding: EdgeInsets.symmetric(horizontal: 8),
    child:
 ListView(
    children: [
      SizedBox(height:80 ,),
      Center(
        child: Text(
          "WELCOME TO",
          style: GoogleFonts.acme(
            fontSize: 40.0,
            color: Colors.white,
          ),
        ),
      ),

      // Column widget will stack the image and text vertically
    Column(
    mainAxisSize: MainAxisSize.min, // Ensures the Column takes only as much space as needed
    children: [
    Image.network(
    'https://raw.githubusercontent.com/Fadysamy55/ppro/refs/heads/main/scholar.png',
    ),
    // Add space between the image and the text if needed
    SizedBox(height: 10),
    // The "Scholar Chat" text, positioned directly under the image
    Text(
    "Scholar Chat",
    style: GoogleFonts.pacifico(
    fontSize: 32.0,
    color: Colors.white,
    ),
    ),
    ],
),
      SizedBox(height: 20,),
      Center(
        child: Text(
          "“A simple and fast chat application that allows users to communicate easily in real time, with an easy-to-use interface and a comfortable design that suits everyone.”",
          style: GoogleFonts.acme(
            fontSize: 25.0,
            color: Colors.white54,
          ),
        ),
      ),
      SizedBox(height: 20),
    Center(
    child: GestureDetector(
    onTap: () {
    // الانتقال إلى الصفحة الثانية
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Login()),
    );
    },
    child: Container(
    width: 60, // عرض الدائرة
    height: 60, // ارتفاع الدائرة
    decoration: BoxDecoration(
    color: Colors.white, // لون الدائرة
    shape: BoxShape.circle, // شكل الدائرة
    ),
    child: Center(
    child: Icon(
    Icons.arrow_forward, // رمز السهم
    color: Colors.blueGrey[900], // لون السهم
    size: 30, // حجم السهم
    ),
    ),

    )
    )
    )
        ]
)
)
)

)
;
  }
}
