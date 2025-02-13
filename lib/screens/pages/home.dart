import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:governement_service_app/screens/pages/bookmark_screen.dart';
import 'package:governement_service_app/utils/helpers/internet_provider.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  List<Map<String, dynamic>> allServices = [
    {
      "title": "Aadhaar",
      "logo":
          "https://upload.wikimedia.org/wikipedia/hi/thumb/c/cf/Aadhaar_Logo.svg/1200px-Aadhaar_Logo.svg.png",
      "url": "https://uidai.gov.in/",
    },
    {
      "title": "National Portal",
      "logo":
          "https://www.india.gov.in/sites/upload_files/npi/files/logo_1.png",
      "url": "https://www.india.gov.in/",
    },
    {
      "title": "Service Portal",
      "logo":
          "https://v2.india.gov.in/_next/image?url=%2Fimage%2Ficons%2Fnpi_logo.webp&w=640&q=75",
      "url": "https://services.india.gov.in/",
    },
    {
      "title": "Mygov",
      "logo":
          "https://tse4.mm.bing.net/th?id=OIP.2dL0KFKjP1bNDF0HZ7wRxAHaEK&pid=Api&P=0&h=180",
      "url": "https://www.mygov.in/",
    },
    {
      "title": "Parivahan",
      "logo":
          "https://c.ndtvimg.com/2021-12/d8kk2gj8_car_625x300_27_December_21.jpg",
      "url": "https://parivahan.gov.in/parivahan/en",
    },
    {
      "title": "DigiLocker",
      "logo":
          "https://upload.wikimedia.org/wikipedia/commons/thumb/1/1f/DigiLocker.svg/2560px-DigiLocker.svg.png",
      "url": "https://www.digilocker.gov.in/",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Govt. Service App"),
          backgroundColor: Colors.blueAccent,
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BookmarkScreen()));
                },
                icon: Icon(
                  Icons.bookmark,
                  color: Colors.white,
                  size: 28,
                ))
          ],
        ),
        body: (Provider.of<Internetprovider>(context).connectivityResult !=
                ConnectivityResult.none)
            ? Padding(
                padding: const EdgeInsets.all(10.0),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemCount: allServices.length,
                  itemBuilder: (context, i) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed('detail_page',
                            arguments: allServices[i]);
                      },
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                              allServices[i]['logo'],
                            ),
                            SizedBox(height: 10),
                            Text(
                              "${allServices[i]['title']}",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            : Center(
                child: Text(
                  "No internet Connection",
                  style: TextStyle(fontSize: 16),
                ),
              ));
  }
}
