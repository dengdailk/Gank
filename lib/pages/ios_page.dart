import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gank/entity/ios.dart';
import 'package:gank/service/service_methon.dart';
import 'package:gank/widgets/ios_item_widget.dart';

class IosPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _IosPageState();
}

class _IosPageState extends State with AutomaticKeepAliveClientMixin{
  List<IosResults> iosData;
  int _index = 1;

  @override
  void initState() {
    iosData = List();
    _refresh();
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('iOS'),
      ),
      body: Container(
        width: ScreenUtil().setWidth(1080),
        child: EasyRefresh(
          child: listWidget(),
          onLoad: () async {
            _refresh();
          },
        ),
      ),
    );
  }

  // 带滚动条的列表
  Widget listWidget() => ListView.builder(
    itemBuilder: (context, index) {
      return IosItemWidget(results: iosData[index]);
    },
    itemCount: iosData.length,
  );

  // 上拉加载更多
  void _refresh() {
    getIosData(_index++).then((data) {
      setState(() {
        Ios ios = Ios.fromJsonMap(data);
        iosData.addAll(ios.results);
      });
    });
  }
}