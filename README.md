# aev lib
> 优鲜直采网`flutter`项目基础框架

## core
```
  Aev()
      .useTitle("优鲜crm")
      .useRouter(routerFactory())
      .useTheme(ThemeData(primaryColor: CrmColors.subColor))
      .useFetchWithMiddlewares(middlewares: [
    //  设置阻断
    fuse,
    token(tokenFactory: () async {
      final user = await Ioc.inject<Future<SignUser>>();
      return user?.token;
    }),
    ycFilter((YcError error) async {
      Toast toast = Ioc.inject<Toast>();
      toast.danger(error.message);
      if (error.statusCode == 403) {
        var sf = await Ioc.inject<Future<SharedPreferences>>();
        sf.setString("userInfo", null);
      }
      print(error);
    }),
  ]).start();
```
## AevRouter
```
  final router = AevRouter();
  // 首页
  router.define("/", (params, ctx) {
    return VerificationToken(WillPopScope(
      onWillPop: HelpTools.doubleExit(() {
        toast.warning("再点一次，退出应用");
      }),
      child: Home(),
    ));
  });
```

## Ioc
```
Ioc.provider<Toast>(Toast());
```

## Toast
```
 toast.danger(error.message);
```

等等  

> 源代码是最好的文档







