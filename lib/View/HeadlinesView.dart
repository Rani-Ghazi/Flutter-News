import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/Services/Api.dart';
import 'package:flutter_news_app/View/ArticlesDetailView.dart';

class HeadlinesView extends StatefulWidget {
  const HeadlinesView({Key? key}) : super(key: key);

  @override
  State<HeadlinesView> createState() => _HeadlinesViewState();
}

class _HeadlinesViewState extends State<HeadlinesView> {
  late final Future<List<Map<String, dynamic>>> articles;

  @override
  void initState() {
    super.initState();
    articles = Api().fetchDataFromApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("News App"),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: articles,
      builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (snapshot.hasData) {
          return _buildGridView(snapshot.data!);
        } else {
          return const Center(child: Text("No data available"));
        }
      },
    );
  }

  Widget _buildGridView(List<Map<String, dynamic>> data) {
    return GridView.builder(
      itemCount: data.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (BuildContext _, int index) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ArticlesDetailView(data[index]),
              ),
            );
          },
          child: _buildGridTile(data[index]),
        );
      },
    );
  }

  Widget _buildGridTile(Map<String, dynamic> item) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridTile(
        child: _buildImage(item['urlToImage']),
        footer: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            item['title'] ?? '',
            style: const TextStyle(fontWeight: FontWeight.bold),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  Widget _buildImage(String? imageUrl) {
    return CachedNetworkImage(
      imageUrl: imageUrl ?? '',
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) => const Center(
        child: SizedBox(
          height: 50,
          width: 50,
          child: CircularProgressIndicator(),
        ),
      ),
      errorWidget: (context, url, error) => Container(),
    );
  }
}
