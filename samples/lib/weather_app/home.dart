import 'package:flutter/material.dart';
import 'package:samples/weather_app/model/weatherModel.dart';
import 'package:samples/weather_app/services/weatherServices.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Weathermodel> datas = [];
  Weatherservices service = Weatherservices();

  Future<void> getWeatherData() async {
    // Bu bir Future döndüreceği için await ile beklemeliyiz.
    datas = await service.getDatas();
    setState(() {
      datas;
    }); // Veri geldikten sonra UI güncellemek için setState() kullanmalısınız.
  }

  @override
  void initState() {
    super.initState();
    getWeatherData();
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
                      'assets/frame2.png',
                    ),
                    fit: BoxFit.contain),
              ),
              child: Padding(
                  padding: EdgeInsets.only(left: 20, bottom: 35),
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
                              ListTile(
                                title: Text(
                                  datas[index].max!,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 50,
                                      fontWeight: FontWeight.w500),
                                ),
                                subtitle: Text(
                                  datas[index].description!.toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400),
                                ),
                                trailing: Padding(
                                  padding: const EdgeInsets.only(top: 30, right: 30,),
                                  child: Text(datas[index].date! + '\n' + datas[index].day!, style: TextStyle(
                                    
                                  ),),
                                ),
                              ),
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
                                'Ankara/Türkiye',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                '${datas[index].min}° ~ ${datas[index].max}°',
                                style: TextStyle(
                                    color: Colors.white,
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