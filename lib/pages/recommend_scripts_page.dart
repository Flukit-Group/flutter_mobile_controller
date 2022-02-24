

import 'package:flutter/material.dart';

class RecommendScriptsPage extends StatefulWidget {
  const RecommendScriptsPage({Key? key}) : super(key: key);

  @override
  _RecommendScriptsPageState createState() => _RecommendScriptsPageState();
}

class _RecommendScriptsPageState extends State<RecommendScriptsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        crossAxisCount: 4,
        padding: EdgeInsets.all(12),
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        shrinkWrap: true,
        children: [
          _buildItem(),
          _buildItem(),
          _buildItem(),
          _buildItem(),
          _buildItem(),
          _buildItem(),
        ],
      ),
    );
  }

  _buildItem() => TextButton(
    child: Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.16),
        borderRadius: BorderRadius.circular(12),

      ),
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Icon(Icons.deck_sharp, size: 36, color: Colors.black,),
          SizedBox(height: 18,),
          Text('微信直播自动评论脚本', style: Theme.of(context).textTheme.headline6?.copyWith(color: Colors.black),)
        ],
      ),
    ),
    onPressed: () {

    },
  );
}
