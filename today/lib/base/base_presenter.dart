import 'package:today/base/base_model.dart';
import 'package:today/base/base_view.dart';

abstract class BasePresenter<M extends BaseModel, V extends BaseView> {
  final M model;
  
  final V view;

  BasePresenter(this.model,this.view) {
    this.model.attach(this);
  }
}
