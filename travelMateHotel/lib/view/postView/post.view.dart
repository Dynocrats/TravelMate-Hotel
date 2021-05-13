import 'package:flutter/material.dart';

class PostView extends StatefulWidget {
  @override
  _PostViewState createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 400.0,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/hotel.jpg'), fit: BoxFit.cover),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50.0),
                    bottomRight: Radius.circular(50.0))),
            child: Stack(
              children: [
                Positioned(
                    top: 20.0,
                    left: 10.0,
                    child: IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        onPressed: () => Navigator.pop(context)))
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [

                  Container(
                    child: Row(
                      children: [
                        Expanded(
                            child: Container(
                              margin: EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'HOTEL NAME',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Row(
                                children: [
                                  Text('FEATURES'),
                                  SizedBox(
                                    width: 20.0,
                                  ),
                                  Icon(Icons.king_bed),
                                  Icon(Icons.wifi),
                                  Icon(Icons.train)
                                ],
                              )
                            ],
                          ),
                        )),
                        Expanded(
                        child: Container(
                          child: Text('USD7.5 / one day', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),),
                        )),
                      ],
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Text(
                      'Lorem ipsum dolor sit amet consectetur adipiscing, elit neque aliquam per dignissim, eu sociosqu aliquet ut lacus. Nibh facilisi nullam potenti aliquam vivamus metus habitant in tempus lobortis, vulputate et diam orci vitae primis nec semper taciti phasellus, eleifend fames blandit facilisis netus congue nulla posuere tellus. Cursus vestibulum est sociis blandit mauris lectus ante luctus venenatis class ultrices, pharetra pretium penatibus habitasse aliquam euismod porttitor aliquet id.',
                      textAlign: TextAlign.justify,
                    ),
                  ),

                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(20.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.blue[200]
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
