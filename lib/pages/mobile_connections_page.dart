
import 'package:fluent_ui/fluent_ui.dart';

class MobileConnectionPage extends StatefulWidget {
  const MobileConnectionPage({Key? key}) : super(key: key);

  @override
  _MobileConnectionPageState createState() => _MobileConnectionPageState();
}

class _MobileConnectionPageState extends State<MobileConnectionPage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.withPadding(
      header: const PageHeader(title: Text('Mobile Connections')),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
      content: Container(
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.16),
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: Colors.grey, width: 0.8)
                ),
                // TODO: Display connected devices list panel.
                child: Placeholder(),
              ),

            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('setting 1'),
                    SizedBox(height: 20,),
                    Text('setting 2'),
                    SizedBox(height: 20,),
                    Text('setting 3'),
                    SizedBox(height: 20,),
                    Text('setting 4'),
                    SizedBox(height: 20,),
                    Text('setting 5'),
                    SizedBox(height: 20,),
                    Text('setting 6'),
                    SizedBox(height: 20,),
                  ],
                ),
              ),

            ),
          ],
        ),
      ),
    );
  }
}
