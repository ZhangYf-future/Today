import 'package:permission_handler/permission_handler.dart';

class PermissionUtils {

  //判断是否用于某一个权限
  static Future<bool> checkHavePermission(Permission permission) async{
    return await permission.status == PermissionStatus.granted;
  }

  //请求某一个权限
  static Future<bool> requestPermission(Permission permission) async{
    return await permission.request() == PermissionStatus.granted;
  }

  //判断是否拥有某一组权限
  static Future<bool> checkHavePermissions(List<Permission> permissionList) async {
    if(permissionList.isEmpty){
      return true;
    }
    for(Permission permission in permissionList){
      if(await permission.status != PermissionStatus.granted){
        return false;
      }
    }
    return true;
  }

  //请求某一组权限，如果请求成功返回true，请求失败返回false
  static Future<bool> requestPermissions(List<Permission> permissionList) async{
    
    for(Permission permission in permissionList){
      if(await permission.status != PermissionStatus.granted){
        //没有当前权限才去请求
        if(await permission.request() != PermissionStatus.granted){
          //没有请求到当前权限
          return false;
        }
      }
    }

    return true;
  }

}