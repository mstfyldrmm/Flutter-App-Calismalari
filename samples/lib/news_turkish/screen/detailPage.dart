import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iconsax/iconsax.dart';
import 'package:samples/news_turkish/model/result.dart';
import 'package:samples/news_turkish/screen/home.dart';
import 'package:samples/news_turkish/screen/navigate_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatelessWidget with NavigatorManager {
  const DetailPage({super.key, required this.model});
  final Results model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(
          'Gündemdeyiz',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_sharp)),
      ),
      body: ListView(
        children: [
          Container(
            height: 350,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image:
                        NetworkImage(model.imageUrl ?? 'assets/no-image.png'),
                    fit: BoxFit.contain)),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 20, top: 40),
            child: Column(
              children: [
                Text(
                  model.title ?? '',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 20,
                      ),
                  textAlign: TextAlign.start,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(model.sourceName ?? ''),
                      Text(model.pubDate ?? '')
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: Text(
                    model.description ?? '',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontSize: 17),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Color.fromARGB(255, 10, 34, 75),
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            child: GestureDetector(
              onTap: () async {
                await launchUrl(
                  Uri.parse(model.link ?? '')
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Kaynağa Git',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontSize: 20),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: Colors.white,
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
