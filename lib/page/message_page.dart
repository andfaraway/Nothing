import 'package:nothing/constants/constants.dart';
import 'package:nothing/model/message_model.dart';
import '/public.dart';
import 'package:nothing/widgets/request_loading_widget.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  late final RefreshController _refreshController;

  List<MessageModel> dataList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshController = RefreshController();
    loadData();

    globalContext = context;
  }

  Future<void> loadData() async {
    String? alias = await LocalDataUtils.get(KEY_ALIAS);
    List? list = await API.getMessages(alias);
    if (list == null) {
      showToast(S.current.request_failed);
      _refreshController.refreshCompleted();
      return;
    }

    dataList.clear();
    for (Map<String, dynamic> map in list) {
      MessageModel model = MessageModel.fromJson(map);
      dataList.add(model);
    }
    _refreshController.refreshCompleted();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      appBar: AppBar(
        title: Text(S.current.message),
      ),
      body: SmartRefresher(
        onRefresh: () {
          loadData();
        },
        controller: _refreshController,
        child: dataList.isEmpty
            ? const RequestLoadingWidget()
            : SingleChildScrollView(
                padding:
                    const EdgeInsets.only(bottom: kBottomNavigationBarHeight),
                child: Column(
                    children: dataList.isEmpty
                        ? [Center(child: Text(S.current.no_message))]
                        : dataList
                            .map((model) => messageWidget(model))
                            .toList()),
              ),
      ),
    );
  }

  Widget messageWidget(MessageModel model) {
    return GestureDetector(
      onLongPress: () async {
        showConfirmToast(
            context: context,
            title: '??????????????????',
            onConfirm: () async {
              await API.deleteMessages(model.id.toString());
              loadData();
            });
      },
      child: Padding(
        padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 30.w),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
          child: Padding(
            padding: EdgeInsets.only(
                left: 45.w, right: 45.w, top: 36.h, bottom: 36.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        model.title ?? 'nothing',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 32.sp,
                            fontWeight: FontWeight.bold),
                        maxLines: 2,
                      ),
                    ),
                    Text(
                      model.date?.dataFormat('yyyy-MM-dd hh-mm-ss') ?? '',
                      style: TextStyle(
                        color: const Color(0xff888888),
                        fontSize: 28.sp,
                      ),
                    )
                  ],
                ),
                30.hSizedBox,
                model.type != 5
                    ? Text(
                        model.content ?? '',
                        style: TextStyle(
                          color: const Color(0xff888888),
                          fontSize: 28.sp,
                        ),
                      )
                    : SizedBox(
                        width: double.infinity,
                        child: Text(
                          model.content ?? '',
                          style: TextStyle(
                            color: const Color(0xff888888),
                            fontSize: 28.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
