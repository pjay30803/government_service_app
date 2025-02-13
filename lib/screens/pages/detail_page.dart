import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';

import '../../utils/helpers/bookmark_provider.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  InAppWebViewController? _webViewController;
  late PullToRefreshController _pullToRefreshController;
  int _bottomNavIndex = 0;

  @override
  void initState() {
    super.initState();
    _pullToRefreshController = PullToRefreshController(
      settings: PullToRefreshSettings(color: Colors.blue),
      onRefresh: () => _webViewController?.reload(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bookmarkProvider = Provider.of<BookmarkProvider>(context);
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(args['title']),
        actions: [
          IconButton(
            icon: Icon(
              bookmarkProvider.bookmarks.contains(args)
                  ? Icons.bookmark
                  : Icons.bookmark_border,
            ),
            onPressed: () => bookmarkProvider.changeBookmark(args),
          ),
        ],
      ),
      body: InAppWebView(
        pullToRefreshController: _pullToRefreshController,
        initialUrlRequest: URLRequest(url: WebUri(args['url'])),
        onWebViewCreated: (controller) => _webViewController = controller,
        onLoadStop: (_, __) => _pullToRefreshController.endRefreshing(),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _bottomNavIndex,
        onDestinationSelected: (index) async {
          setState(() => _bottomNavIndex = index);
          switch (index) {
            case 0:
              await _webViewController?.loadUrl(
                  urlRequest: URLRequest(url: WebUri(args['url'])));
              break;
            case 1:
              await _webViewController?.reload();
              break;
            case 2:
              await _webViewController?.goBack();
              break;
            case 3:
              await _webViewController?.goForward();
              break;
          }
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.refresh), label: 'Refresh'),
          NavigationDestination(
              icon: Icon(Icons.arrow_back_ios), label: 'Back'),
          NavigationDestination(
              icon: Icon(Icons.arrow_forward_ios), label: 'Forward'),
        ],
      ),
    );
  }
}
