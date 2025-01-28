import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:samples/news_turkish/model/category.dart';
import 'package:samples/news_turkish/screen/detailPage.dart';
import 'package:samples/news_turkish/view_model/result_list_view_model.dart';
import 'package:samples/to_do_list_app.dart/screen/navigator_manager.dart';

class HomeScreenNews extends StatefulWidget {
  const HomeScreenNews({super.key});

  @override
  State<HomeScreenNews> createState() => _HomeScreenNewsState();
}

class _HomeScreenNewsState extends State<HomeScreenNews> with NavigatorManager{
  List<Category> kategori = [
    Category('top', 'Genel'),
    Category('business', 'İş'),
    Category('entertainment', 'Eğlence'),
    Category('health', 'Sağlık'),
    Category('science', 'Bilim'),
    Category('sports', 'Spor'),
    Category('world', 'Dünya'),
    Category('environment', 'Çevre'),
    Category('politics', 'Politika'),
    Category('technology', 'Teknoloji'),
  ];

  @override
  Widget build(BuildContext context) {
    final rmv = Provider.of<ResultListViewModel>(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: ListTile(
            title: Text(
              'Gündemdeyiz',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            subtitle: Text('Türkiyeden Anlık Haberler',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium),
          )),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            CategoryWidget(kategori: kategori, rmv: rmv,),
            Expanded(
                child: getWidgetByStatusNews(rmv))
          ],
        ),
      ),
    );
  }
    
  Widget getWidgetByStatusNews(ResultListViewModel rvm) {
    switch (rvm.status.index) {
      case 2:
        return MasonryGridView.builder(
                    gridDelegate:
                        SliverSimpleGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemCount: rvm.viewModel.results.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () => navigateToWidget(context, DetailPage(model: rvm.viewModel.results[index])),
                        child: Card(
                          color: const Color.fromARGB(255, 10, 34, 75),
                          margin: EdgeInsets.all(10),
                          child: IntrinsicWidth(
                            child: Column(
                              children: [
                                Image.network(rvm
                                        .viewModel.results[index].imageUrl ??
                                    'https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg',
                                    errorBuilder: (context, error, stackTrace) {
                                      return Text('Resim Yüklenemedi');
                                    },
                                    ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 10, top: 10, bottom: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          rvm.viewModel.results[index].sourceName ??
                                              '',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis
                                        ),
                                      ),
                                      Text(rvm.viewModel.results[index].pubDate!
                                              .substring(11, 13) + ' S' ??
                                          '')
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, bottom: 10, right: 30),
                                  child: Text(
                                    rvm.viewModel.results[index].title ?? '',
                                    style: Theme.of(context).textTheme.bodyLarge,
                                    textAlign: TextAlign.left,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    });

      default:
        return Center(child: CircularProgressIndicator(color: Color.fromARGB(255, 10, 34, 75)));
    }
  }
}

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    super.key,
    required this.kategori, required this.rmv,
  });

  final List<Category> kategori;
  final ResultListViewModel rmv;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: kategori.length,
          itemBuilder: (context, index) {
            return Card(
              color: Color.fromARGB(255, 10, 34, 75),
              margin: EdgeInsets.all(10),
              child: GestureDetector(
                onTap: () => rmv.getNews(kategori[index].key),
                child: Padding(
                  padding: const EdgeInsets.only(right: 20, top: 10, left: 20),
                  child: Text(
                    kategori[index].title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
