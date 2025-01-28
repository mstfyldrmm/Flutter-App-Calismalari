import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:samples/news_app/viewModel/articleListViewModel.dart';
import 'package:samples/news_app/viewModel/articleViewModel.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> categories = [
    'Business',
    'Entertainment',
    'General',
    'Health',
    'Science',
    'Sports',
    'Technology'
  ];

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ArticleListViewModel>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'American News',
          ),
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        body: Column(
          children: [
            SizedBox(
              height: 60,
              child: ListView.builder(
                  itemCount: categories.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: getCategoriesTab(vm)[index],
                      ),
                    );
                  }),
            ),
            Expanded(child: getWidgetByStatus(vm))
          ],
        ));
  }

  List<GestureDetector> getCategoriesTab(ArticleListViewModel vm) {
    List<GestureDetector> list = [];
    
    for (int i = 0; i < categories.length; i++) {
      list.add(GestureDetector(
        onTap: () => vm.getNews(categories[i]),
        child: Text(categories[i]),
      ));
    }
    return list;
  }
}

Widget getWidgetByStatus(ArticleListViewModel vm) {
  switch (vm.status.index) {
    case 2:
      return ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Card(
              margin: EdgeInsets.only(bottom: 20),
              child: Column(
                children: [
                  Image.network(vm.viewModel.articles[index].urlToImage ??
                      'hhttps://commons.wikimedia.org/wiki/File:No_Image_Available.jpg'),
                  ListTile(
                    title: Text(vm.viewModel.articles[index].title!),
                    titleTextStyle: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                    subtitle: Text(vm.viewModel.articles[index].description ?? 'No description available')
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                        onPressed: () async {
                          await launchUrl(
                            Uri.parse(vm.viewModel.articles[index].url ?? ''),
                            // veya LaunchMode.externalApplication
                          );
                        },
                        child: Text('Go to the news page')),
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: vm.viewModel.articles.length,
      );
    default:
      return Center(child: CircularProgressIndicator());
  }
}
