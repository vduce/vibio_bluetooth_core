import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vibio_bluetooth_core_example/UI/ui_data/call_back.dart';
import 'package:vibio_bluetooth_core_example/UI/ui_data/main_view_type.dart';


class CMDView extends StatefulWidget{

  CMDView({required Key key, required this.todo, required this.onCmdTap}) : super(key: key);
  final MainType todo;
  @required final cmdTapFuncCallback onCmdTap;

  @override
  _CMDViewState createState() => _CMDViewState(todo, onCmdTap);
}

class _CMDViewState extends State<CMDView> {
  var todo;
  cmdTapFuncCallback oncmdTap;
  _CMDViewState(this.todo, this.oncmdTap);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    MainType todoType = todo;
    List<String> names = todoType.names;
    double height;
    int type;
    height = todoType.height;
    type = todoType.type;


    // TODO: implement build
    return new Container(
      color: Colors.amberAccent,
      height: height,
      child: GridView(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          // 一行几列
          crossAxisCount: 4,
          // 设置每子元素的大小（宽高比）
          childAspectRatio: 1.5,
          // 元素的左右的 距离
          crossAxisSpacing: 1,
          // 子元素上下的 距离
          mainAxisSpacing: 2,
        ),
        children: new List.generate(names.length, (index) {
          return new Center(
            child: new MaterialButton(onPressed: () {
              this.oncmdTap(index, type);
            }, child:
            new Text(names[index], style: Theme.of(context).textTheme.subtitle1,), color: Colors.blue,),
          );
        }),
      ),
    );
  }
}

