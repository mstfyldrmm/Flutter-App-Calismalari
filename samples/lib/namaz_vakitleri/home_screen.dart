import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:samples/namaz_vakitleri/model/calcTimes.dart';
import 'package:samples/namaz_vakitleri/model/times.dart';
import 'package:samples/namaz_vakitleri/services/servicesVakit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _timeString = '';
  List<Times> vakitler = [];
  List<CalculateTime> kalanVakit = [];
  VakitServices service = VakitServices();
  int remainingSeconds = 0; // Kalan süreyi saniye cinsinden tutacak
  Timer? countdownTimer; // Geri sayım için kullanılacak Timer
  
  @override
  void initState() {
    super.initState();
    _getTime();
    getTimesData();
    // Her saniye bir Timer oluştur, callback fonksiyonuyla saati güncelle
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
  }

  Future<void> getTimesData() async {
    vakitler = await service.getDatas();
    kalanVakit = await service.getRemainingTime();
    String remainingTime =  kalanVakit[0]!.remainingTime!;
    setState(() {
      remainingSeconds = int.parse(remainingTime) * 60;
    });
    startTimer();
  }

  // Saati al ve UI'ı güncelle
  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedTime = _formatTime(now);
    setState(() {
      _timeString = formattedTime;
    });
  }

    void startTimer() {
    countdownTimer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (remainingSeconds > 0) {
        setState(() {
          remainingSeconds--; // Her saniye 1 saniye azalt
        });
      } else {
        timer.cancel(); // Süre dolduğunda Timer'ı durdur
      }
    });
  }

  String formatDuration(int seconds) {
    int minutes = seconds ~/ 60; // Dakika kısmını bul
    int remainingSeconds = seconds % 60; // Saniye kısmını bul

    // Dakika ve saniye formatını uygun şekilde döndür
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }


  // Saati formatla (HH:mm:ss)
  String _formatTime(DateTime time) {
    return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:${time.second.toString().padLeft(2, '0')}";
  }

    @override
  void dispose() {
    countdownTimer?.cancel(); // Timer'ı kapatmayı unutmayın
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 4,
              child: Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      filterQuality: FilterQuality.high,
                      image: AssetImage(ProjectString.containerImagePath),
                      fit: BoxFit.cover),
                  boxShadow: [
                    BoxShadow(
                      color:
                          Color(0xffECD8C5).withOpacity(0.2), // Gölgenin rengi
                      offset: Offset(0, 6), // Gölgenin y ekseninde ofseti
                      blurRadius: 40, // Bulanıklık yarıçapı
                      spreadRadius: 10, // Gölgenin yayılma yarıçapı
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 55),
                      child: Center(
                        child: Container(
                          width: 300,
                          height: 200,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(ProjectString.saatImagePath))),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  _timeString,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                          fontSize: 30, fontWeight: FontWeight.w700, color: Colors.black),
                                ),
                                Text(
                                  '10 Ekim Perşembe',
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Text(
                              kalanVakit.isEmpty ?  '' :
                              '${kalanVakit[0].vakit} vaktine kalan süre',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.qwitcherGrypen(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 30),
                            ),
                          ),
                          Text(formatDuration(remainingSeconds), style: Theme.of(context).textTheme.headlineLarge,)
                  ],
                ),
              )),
          Expanded(
              flex: 3,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.only(top: 10),
                    color: ProjectColor().colors[index],
                    child: ListTile(
                      leading: ProjectIcons().icons[index],
                      title: Text(
                        vakitler[index].vakit!,
                        style: GoogleFonts.qwitcherGrypen(
                          fontWeight: FontWeight.w600,
                          fontSize: 30,
                        ),
                      ),
                      subtitle: Text(vakitler[index].saat!),
                      trailing: Text(vakitler[index].saat!,
                          style: Theme.of(context).textTheme.bodyLarge),
                    ),
                  );
                },
                itemCount: vakitler.length,
                padding: EdgeInsets.all(20),
              ))
        ],
      ),
    );
  }
}

class ProjectString {
  static String containerImagePath = 'assets/png/bg.png';
  static String saatImagePath = 'assets/png/saat.png';
}

class ProjectColor {
  List<Color> colors = [
    Color(0XFF9284EC),
    Color(0XFFF8E38F),
    Color(0XFFCBE8A6),
    Color(0XFFE8C6B7),
    Color(0XFFCDD2F6),
    Color(0XFFB4DADA)
  ];
  static Color deepPurple = Color(0XFF9284EC);
  static Color brown = Color(0XFFECD8C5);
  static Color green = Color(0XFFCBE8A6);
  static Color red = Color(0XFFE8C6B7);
  static Color blue = Color(0XFFCDD2F6);
}

class ProjectIcons {
  List<Icon> icons = [
    Icon(
      MdiIcons.weatherSunset,
      size: 40,
    ),
    Icon(
      MdiIcons.weatherSunsetUp,
      size: 40,
    ),
    Icon(
      MdiIcons.whiteBalanceSunny,
      size: 40,
    ),
    Icon(
      MdiIcons.sunAngle,
      size: 40,
    ),
    Icon(
      MdiIcons.weatherSunsetDown,
      size: 40,
    ),
    Icon(
      MdiIcons.weatherNight,
      size: 40,
    ),
  ];
}
