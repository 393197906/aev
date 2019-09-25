/// 正则表达式
class Regexp {
  static RegExp number = RegExp(r"^[0-9]*\.?[0-9]*$"); // 数字
  static RegExp float = RegExp(r"^(-?\d+)(\.\d+)?$"); // 浮点数
  static RegExp zh = RegExp(r"^[\u4e00-\u9fa5]{0,}$"); // 汉字
  static RegExp mobilePhone = RegExp(
      r"^(13[0-9]|14[0-9]|15[0-9]|166|17[0-9]|18[0-9]|19[8|9])\d{8}$"); // 汉字
  static RegExp telPhone = RegExp(r"^\d{3}-\d{7,8}|\d{4}-\d{7,8}$"); // 固定电话
  static RegExp email = RegExp(
      r"^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$"); // 邮箱
}
