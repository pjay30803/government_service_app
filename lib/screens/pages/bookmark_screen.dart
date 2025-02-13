import 'package:flutter/material.dart';
import 'package:governement_service_app/screens/pages/detail_page.dart';
import 'package:governement_service_app/utils/helpers/bookmark_provider.dart';
import 'package:provider/provider.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bookmarkProvider = Provider.of<BookmarkProvider>(context);
    final bookmarks = bookmarkProvider.bookmarks;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Bookmarks",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 28),
          ),
          centerTitle: true,
        ),
        body: bookmarks.isEmpty
            ? Center(
                child: Text(
                  "No bookmarks",
                  style: TextStyle(fontSize: 16),
                ),
              )
            : ListView.builder(
                itemCount: bookmarks.length,
                itemBuilder: (context, index) {
                  final service = bookmarks[index];
                  return ListTile(
                    leading: Image.network(service['logo']),
                    title: Text(service['title']),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailPage(),
                              settings: RouteSettings(arguments: service)));
                    },
                    trailing: IconButton(
                        onPressed: () {
                          bookmarkProvider.changeBookmark(service);
                        },
                        icon: Icon(Icons.delete)),
                  );
                }));
  }
}
