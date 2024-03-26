import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ArticlesDetailView extends StatelessWidget {
  final Map<String, dynamic> article;

  ArticlesDetailView(this.article);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildArticleImage(),
              SizedBox(height: 25),
              _buildAuthor(),
              SizedBox(height: 45),
              _buildTitle(),
              SizedBox(height: 25),
              Expanded(child: _buildDescription()),
              _buildPublishedDate(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildArticleImage() {
    return CachedNetworkImage(
      imageUrl: article['urlToImage'],
      imageBuilder: (context, imageProvider) => Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
        ),
      ),
      placeholder: (context, url) => Center(
        child: SizedBox(
          height: 70,
          width: 70,
          child: CircularProgressIndicator(),
        ),
      ),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }

  Widget _buildAuthor() {
    return Center(
      child: Text(
        'Author: ${article['author'] ?? 'Unknown'}',
        style: TextStyle(fontSize: 15),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      '${article['title'] ?? ''}:',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, wordSpacing: 3),
    );
  }

  Widget _buildDescription() {
    return Text(
      article['description'] ?? '',
      style: TextStyle(fontSize: 17, wordSpacing: 3),
    );
  }

  Widget _buildPublishedDate() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Text(
          'Published At: ${_formatPublishedDate()}',
          style: TextStyle(color: Color.fromARGB(255, 174, 174, 174), fontSize: 16),
        ),
      ),
    );
  }

  String _formatPublishedDate() {
    final DateTime publishedAt = DateTime.parse(article['publishedAt'] ?? '');
    return DateFormat.yMMMMEEEEd('en-us').format(publishedAt);
  }
}
