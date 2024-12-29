# TLE解析器
## 介绍
TLE解析器为[卫星百科](https://sat.huijiwiki.com/)而设计，用于将TLE数据解析为卫星的轨道六根数。
## 输入
示例：
```
0 ISS (ZARYA)
1 25544U 98067A   24137.20363426  .00020937  00000-0  35601-3 0  9992
2 25544  51.6377 113.9222 0003310 173.3272   0.0417 15.51383595453585
```
每一行对应模板的一个匿名参数。
## 输出
轨道六根数的计算结果封装在一个名为`orbitalElements`的对象中。

`orbitalElements[0]`对应**半长轴**，单位 km。

`orbitalElements[1]`对应**离心率**。

`orbitalElements[2]`对应**轨道倾角**，单位 rad。

`orbitalElements[3]`对应**近心点辐角**，单位 rad。

`orbitalElements[4]`对应**升交点经度**，单位 rad。

`orbitalElements[5]`对应**真近点角**，单位 rad。