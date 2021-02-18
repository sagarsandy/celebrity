import 'package:cached_network_image/cached_network_image.dart';
import 'package:celebrity/services/celebrity_data_provider_service.dart';
import 'package:celebrity/widgets/celeb_list_view_widget.dart';
import 'package:celebrity/widgets/tab_bar_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return CelebrityDataProviderService();
      },
      child: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> homeScreenScaffoldKey =
      GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Provider.of<CelebrityDataProviderService>(context, listen: false)
        .getCelebritiesData(homeScreenScaffoldKey);
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                TabBarItemWidget(title: "Young Celebs (<=50)"),
                TabBarItemWidget(title: "Old Celebs    (>50)"),
              ],
            ),
            title: Text('Celebrities'),
          ),
          body: Consumer<CelebrityDataProviderService>(
            builder: (context, celebrityDataNotifyProvider, _) {
              return TabBarView(
                children: [
                  celebrityDataNotifyProvider.youngCelebrities.length > 0
                      ? CelebListViewWidget(
                          celebrities:
                              celebrityDataNotifyProvider.youngCelebrities)
                      : Center(
                          child: Text("Loading"),
                        ),
                  celebrityDataNotifyProvider.oldCelebrities.length > 0
                      ? CelebListViewWidget(
                          celebrities:
                              celebrityDataNotifyProvider.oldCelebrities)
                      : Center(
                          child: Text("Loading"),
                        ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
