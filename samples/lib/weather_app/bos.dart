import 'package:flutter/material.dart';
import 'package:samples/weather_app/model/weatherModel.dart';
import 'package:samples/weather_app/services/weatherServices.dart';

class Bos extends StatefulWidget {
  const Bos({super.key});

  @override
  State<Bos> createState() => _BosState();
}

class _BosState extends State<Bos> {
  List<Weathermodel> datas = [];
  Weatherservices service = Weatherservices();

  Future<void> getWeatherData() async {
    // Veriler geldikten sonra setState() ile UI'yi güncelliyoruz
    datas = await service.getDatas();
    setState(() {}); // UI'yi güncellemek için setState() çağrısı eklenmeli
  }

  @override
  void initState() {
    super.initState();
    getWeatherData(); // initState içinde verileri çekiyoruz
  }

   @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    bool isLandscape = width > height;

    return Scaffold(
      backgroundColor: Color(0xFFA2DCEE),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/frame.png'), fit: BoxFit.cover),
        ),
        child: ListView.builder(padding: EdgeInsets.only(right: 20,left: 20),itemCount: datas.length,itemBuilder: (context, index) {
          return Container(
              width: isLandscape ? width * 0.7 : width * 0.85,
              height: isLandscape ? height * 0.5 : height * 0.4,
              decoration: BoxDecoration(
                color: Colors.transparent,
                image: DecorationImage(
                    image: AssetImage(
                      'assets/card.png'
                    ),
                    fit: BoxFit.contain),
              ),
              child: Padding(
                  padding: EdgeInsets.only(left: 20, bottom: 35, right: 20),
                  child: 
                    Column(
                      children: [
                        Spacer(
                          flex: 3,
                        ),
                        Expanded(
                          flex: 5,
                          child: Column(
                            children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                  '${datas[index].max!}°',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 50,
                                      fontWeight: FontWeight.w500),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 40),
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    child: Image.network(datas[index].icon!)),
                                )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 30, left: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                    datas[index].description!.toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(datas[index].date! + '\n' + datas[index].day!, style: TextStyle(
                                    color: Color(0xFF132F5B)
                                  ),)
                                    ],
                                  ),
                                ) ,
                              
                            ],
                          ),
                        ),
                        Spacer(),
                        Expanded(
                            child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Kocaeli/Türkiye',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 15),
                              ),
                              Text(
                                '${datas[index].min}° ~ ${datas[index].max}°',
                                style: TextStyle(
                                    color: Color(0xffEBEBF5),
                                    fontWeight: FontWeight.w300),
                              )
                            ],
                          ),
                        )),
                      ],
                  )),
            );
        })
      ),
    );
  }
}