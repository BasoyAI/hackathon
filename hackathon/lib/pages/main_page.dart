import 'package:flutter/material.dart';
import 'package:hackathon/pages/input_page.dart';
import 'package:hackathon/pages/page_controller.dart';

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,  // Klavye açıldığında ekran kaydırılabilir olacak
      body: SingleChildScrollView(  // Ekranın kaydırılabilir olması için eklendi
        child: Container(
          width: 400,
          height: 844,
          color: Color(0xFF14161B),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 737,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 390,
                      height: 44,
                      padding: const EdgeInsets.only(
                        top: 17.17,
                        left: 33.45,
                        right: 20.67,
                        bottom: 15.33,
                      ),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(child: Stack()),
                          Container(
                            width: 66.66,
                            height: 11.34,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 42.33,
                                  top: 0,
                                  child: Container(
                                    width: 24.33,
                                    height: 11.33,
                                    child: Stack(),
                                  ),
                                ),
                                Positioned(
                                  left: 22.03,
                                  top: 0,
                                  child: Container(
                                    width: 17,
                                    height: 10.67,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage("assets/logo.png"),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  top: 0.34,
                                  child: Container(
                                    width: 17,
                                    height: 10.67,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage("assets/logo.png"),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 390,
                      height: 454,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 24,
                            top: 361,
                            child: SizedBox(
                              width: 342,
                              child: Text(
                                'BASOY',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 36,
                                  fontFamily: 'Abhaya Libre ExtraBold',
                                  fontWeight: FontWeight.w800,
                                  height: 0,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 10,
                            top: 25,
                            child: Container(
                              width: 370,
                              height: 370,
                              decoration: ShapeDecoration(
                                color: Color(0x05EB8A53),
                                shape: OvalBorder(),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 54,
                            top: 66,
                            child: Container(
                              width: 283,
                              height: 284,
                              decoration: ShapeDecoration(
                                color: Color(0x19E2E2E2),
                                shape: OvalBorder(),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 306,
                            top: 98,
                            child: Container(
                              width: 18,
                              height: 18,
                              decoration: ShapeDecoration(
                                color: Color(0xFFEAD6CA),
                                shape: OvalBorder(),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 58,
                            top: 274,
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: ShapeDecoration(
                                color: Color(0xFFEAD6CA),
                                shape: OvalBorder(),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 86,
                            top: 98,
                            child: Container(
                              width: 220,
                              height: 220,
                              decoration: ShapeDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/logo.png"),
                                  fit: BoxFit.fill,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(80),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 160,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 360,
                            height: 56,
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28),
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20),
                                    child: TextField(
                                      textAlign: TextAlign.left,  // Ortalama için eklendi
                                      decoration: InputDecoration(
                                        hintText: 'Arama Yapmak İçin Tıklayınız',
                                        hintStyle: TextStyle(
                                          color: Colors.black.withOpacity(0.6),
                                          fontSize: 18,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w500,
                                        ),
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 16.0),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.search,
                                      color: Colors.black.withOpacity(0.6),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PageViewExample(), // Replace this with the page you want to navigate to
                                        ),
                                      );
                                    },
                                  ),
                                ),

                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              'Ger derse Fuzûlî ki güzellerde vefâ var Aldanma ki şair sözü elbette yalandır',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF83899F),
                                fontSize: 20,
                              ),
                            ),
                          ),
                          // Figma Flutter Generator Frame11808788Widget - FRAME
                          Container(
                              width: 390,
                              height: 131,
                              decoration: BoxDecoration(

                              ),
                              child: Stack(
                                  children: <Widget>[
                                    Positioned(
                                        top: 1.5,
                                        left: 153,
                                        child: Container(
                                            width: 85,
                                            height: 85,

                                            child: Stack(
                                                children: <Widget>[
                                                  Positioned(
                                                      top: 13.5,
                                                      left: 19,
                                                      child: Container(
                                                          width: 46,
                                                          height: 57,
                                                          decoration: BoxDecoration(
                                                            borderRadius : BorderRadius.only(
                                                              topLeft: Radius.circular(7),
                                                              topRight: Radius.circular(7),
                                                              bottomLeft: Radius.circular(7),
                                                              bottomRight: Radius.circular(7),
                                                            ),
                                                            image : DecorationImage(
                                                                image: AssetImage('assets/logo.png'),
                                                                fit: BoxFit.fitWidth
                                                            ),
                                                          )
                                                      )
                                                  ),Positioned(
                                                      child: Container(
                                                          width: 85,
                                                          height: 85,
                                                          decoration: BoxDecoration(
                                                            color : Color.fromRGBO(235, 138, 83, 0.019999999552965164),
                                                            borderRadius : BorderRadius.all(Radius.elliptical(85, 85)),
                                                          )
                                                      )
                                                  ),Positioned(
                                                      child: Container(
                                                          width: 65,
                                                          height: 65,
                                                          decoration: BoxDecoration(
                                                            color : Color.fromRGBO(226, 226, 226, 0.10000000149011612),
                                                            borderRadius : BorderRadius.all(Radius.elliptical(65, 65)),
                                                          )
                                                      )
                                                  ),
                                                ]
                                            )
                                        )
                                    ),Positioned(
                                        top: 88,
                                        left: 24,
                                        child: Text('PDF yükle', textAlign: TextAlign.center, style: TextStyle(
                                            color: Color.fromRGBO(131, 137, 159, 1),
                                            fontFamily: 'Abhaya Libre ExtraBold',
                                            fontSize: 20,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.normal,
                                            height: 1.4
                                        ),)
                                    ),
                                  ]
                              )
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [],
              ),
            ],
          ),
        ),
      ),
    );
  }
}