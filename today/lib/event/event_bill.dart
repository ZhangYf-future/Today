///用于通知其它页面账单数据有变化

//定义一个全局变量，可以直接使用这个变量
final BillEvent billEvent = BillEvent();

//有新的账单被添加的回调接口回调接口,现在是直接根据了类型重新查找数据库的数据，后面可以修改为
//返回操作结果，直接根据结果做相应的操作
typedef void BillAChangeEventCallback(int type);

///事件管理类
class BillEvent {
  //定义账单数据变化的类型
  //添加账单
  static const int BILL_CHANGE_ADD = 1;
  //删除账单
  static const int BILL_CHANGE_DELETE = 2;

  //私有构造函数
  BillEvent._internal();

  //保存单例
  static BillEvent _singleton = BillEvent._internal();

  //工厂构造函数
  factory BillEvent() => _singleton;

  //保存事件队列的Map
  final _eventMap = Map<String, List<BillAChangeEventCallback>?>();

  //添加订阅者
  void addObserver(String eventId, BillAChangeEventCallback callback) {
    //查看当前事件id是否已经有相应的事件列表了
    _eventMap[eventId] ??= <BillAChangeEventCallback>[];
    //将当前事件加入进去
    _eventMap[eventId]!.add(callback);
  }

  //移除一个订阅者
  void removeObserver(String eventId, [BillAChangeEventCallback? f]) {
    //查看是否存在当前事件id对应的事件列表
    final list = _eventMap[eventId];

    if (list == null) {
      return;
    }

    if (f == null) {
      _eventMap[eventId] = null;
    } else {
      list.remove(f);
    }
  }

  //触发事件
  void subscribe(String eventId, int type) {
    final list = _eventMap[eventId];
    if (list == null) {
      return;
    }

    list.forEach((element) {
      element(type);
    });
  }
}
