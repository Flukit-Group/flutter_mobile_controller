
import 'package:fluent_ui/fluent_ui.dart';

class RecommendScriptsPage extends StatefulWidget {
  const RecommendScriptsPage({Key? key}) : super(key: key);

  @override
  _RecommendScriptsPageState createState() => _RecommendScriptsPageState();
}

class _RecommendScriptsPageState extends State<RecommendScriptsPage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      content: GridView.count(
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

  _buildItem() => Button(
    child: Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.16),
        borderRadius: BorderRadius.circular(12),

      ),
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Icon(FluentIcons.care_activity, size: 36, color: Colors.black,),
          SizedBox(height: 18,),
          Text('微信直播自动评论脚本', style: FluentTheme.of(context).typography.body?.copyWith(color: Colors.black),)
        ],
      ),
    ),
    style: ButtonStyle(
        border: null,
      shape: null,
      padding: ButtonState.all(EdgeInsets.zero)
    ),
    onPressed: () {

    },
  );
}
