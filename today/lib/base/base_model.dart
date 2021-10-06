import 'package:today/base/base_presenter.dart';

abstract class BaseModel<T extends BasePresenter<dynamic, dynamic>> {
  T presenter;
  get() {
    if (presenter == null) {
      throw Exception("presenter is null.please run attach() first");
    }
    return presenter;
  }

  /// 子类必须在合适的地方尽快调用这个方法，一般在实例化此类的对象后应该立即调用这个方法
  void attach(T presenter) {
    this.presenter = presenter;
    printType();
  }

  void printType() {
    print("presenter is $presenter \n");
  }
}
