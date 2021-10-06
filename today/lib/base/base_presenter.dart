import 'package:today/base/base_model.dart';
import 'package:today/base/base_view.dart';

abstract class BasePresenter<M extends BaseModel, V extends BaseView> {
  M model;
  
  final V view;

  BasePresenter(this.view) {
    this.model = createModel();
    this.model.attach(this);
  }

  M createModel();
}
