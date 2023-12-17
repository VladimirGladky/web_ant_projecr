import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web_ant_project/models/news.dart';
import 'package:intl/intl.dart';

class NewsDetailsScreen extends StatelessWidget {
  const NewsDetailsScreen({
    super.key,
    required this.news,
  });

  final News news;

  @override
  Widget build(BuildContext context) {
    final Uri url = Uri.parse(news.sourceUrl);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 58),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            if (news.imageUrl != null) Image(news: news),
            Title(news: news),
            const Divider(),
            Description(news: news),
            ButtonForLink(url: url),
            Date(news: news)
          ]),
        ),
      ),
    );
  }
}

class Image extends StatelessWidget {
  const Image({
    super.key,
    required this.news,
  });

  final News news;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 235,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          image: DecorationImage(
              image: NetworkImage(
                news.imageUrl!,
              ),
              fit: BoxFit.cover)),
    );
  }
}

class Title extends StatelessWidget {
  const Title({
    super.key,
    required this.news,
  });

  final News news;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Text(
        news.title,
        style: const TextStyle(fontSize: 24),
      ),
    );
  }
}

class Description extends StatelessWidget {
  const Description({
    super.key,
    required this.news,
  });

  final News news;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Text(
        news.description,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}

class ButtonForLink extends StatelessWidget {
  const ButtonForLink({
    super.key,
    required this.url,
  });

  final Uri url;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: MaterialButton(
        onPressed: () {
          _launchInWebView(url);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        color: Colors.white,
        elevation: 1,
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 16),
              child: Icon(Icons.link_outlined),
            ),
            Text('Перейти в источник'),
          ],
        ),
      ),
    );
  }
}

Future<void> _launchInWebView(Uri url) async {
  if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
    throw Exception('Could not launch $url');
  }
}

class Date extends StatelessWidget {
  const Date({
    super.key,
    required this.news,
  });

  final News news;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(children: [
        const Text('Опубликовано:'),
        const SizedBox(width: 5),
        Text(DateFormat.yMd().format(news.published_at!))
      ]),
    );
  }
}
