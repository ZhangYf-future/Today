import 'package:today/base/base_model.dart';
import 'package:today/base/base_presenter.dart';
import 'package:today/bean/comm/home_block_bean.dart';
import 'package:today/ui/home/home_route.dart';
import 'package:today/utils/constant.dart';

//presenter
class HomeRoutePresenter extends BasePresenter<HomeRouteModel, HomeRoute> {
  HomeRoutePresenter(HomeRoute view) : super(view);

  //获取首页列表数据
  List<HomeBlockBean> getHomeBlocks() => this.model.createHomeBlocks();

  @override
  HomeRouteModel createModel() => HomeRouteModel();
}

//Model
class HomeRouteModel extends BaseModel<HomeRoutePresenter> {
  //创建首页需要的数据
  List<HomeBlockBean> createHomeBlocks() {
    //创建一个列表用于存放最终的数据
    final List<HomeBlockBean> homeBlockList = List.empty(growable: true);

    //第一个是账单类型
    final HomeBlockBean billBean = new HomeBlockBean(
        HomeBlockConstant.HOME_BLOCK_TYPE_BILL,
        HomeBlockConstant.HOME_BLOCK_NAME_BILL,
        HomeBlockConstant.HOME_BLOCK_TITLE_BILL,
        null);

    //天气类型
    final HomeBlockBean weatherBean = new HomeBlockBean(
        HomeBlockConstant.HOME_BLOCK_TYPE_WEATHER,
        HomeBlockConstant.HOME_BLOCK_NAME_WEATHER,
        HomeBlockConstant.HOME_BLOCK_TITLE_WEATHER,
        null);

    homeBlockList.add(billBean);
    homeBlockList.add(weatherBean);

    return homeBlockList;
  }
}
