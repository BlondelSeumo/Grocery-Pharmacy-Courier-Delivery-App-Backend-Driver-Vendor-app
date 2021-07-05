import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/models/vendor.dart';
import 'package:fuodz/requests/vendor.request.dart';
import 'package:fuodz/view_models/base.view_model.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:jiffy/jiffy.dart';
import 'package:fuodz/translations/vendor.i18n.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class VendorDetailsViewModel extends MyBaseViewModel {
  //
  int touchedIndex;
  double totalEarning = 0.00;
  int totalOrders = 0;
  List<double> weeklySales = [0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00];
  Vendor vendor;
  VendorRequest vendorRequest = VendorRequest();
  RefreshController refreshController = RefreshController();

  //
  VendorDetailsViewModel(BuildContext context) {
    this.viewContext = context;
  }

  //
  initialise() {
    fetchVendorDetails();
  }

  //
  fetchVendorDetails({bool refresh = false}) async {
    //
    !refresh ? setBusy(true) : refreshController.requestRefresh();

    //
    try {
      final response = await vendorRequest.getVendorDetails();

      //
      totalEarning = double.parse(response["total_earnig"].toString());
      totalOrders = response["total_orders"];
      vendor = Vendor.fromJson(response["vendor"]);
      weeklySales = (response["report"] as List)
          .map((e) => double.parse(e["value"].toString()))
          .toList();
      clearErrors();
    } catch (error) {
      print("Error ==> $error");
      setError(error);
    }
    !refresh ? setBusy(false) : refreshController.refreshCompleted();
  }

  String get WeekFirstDay {
    DateTime today = DateTime.now();
    final formattedDate = today.subtract(Duration(days: today.weekday - 1));
    Jiffy.locale(I18n.localeStr);
    return Jiffy.unix(formattedDate.millisecondsSinceEpoch).yMMMEd;
  }

  String get WeekLastDay {
    DateTime today = DateTime.now();
    final formattedDate =
        today.add(Duration(days: DateTime.daysPerWeek - today.weekday));
    Jiffy.locale(I18n.localeStr);
    return Jiffy.unix(formattedDate.millisecondsSinceEpoch).yMMMEd;
  }

  //
  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay;
              switch (group.x.toInt()) {
                case 0:
                  weekDay = 'Monday'.i18n;
                  break;
                case 1:
                  weekDay = 'Tuesday'.i18n;
                  break;
                case 2:
                  weekDay = 'Wednesday'.i18n;
                  break;
                case 3:
                  weekDay = 'Thursday'.i18n;
                  break;
                case 4:
                  weekDay = 'Friday'.i18n;
                  break;
                case 5:
                  weekDay = 'Saturday'.i18n;
                  break;
                case 6:
                  weekDay = 'Sunday'.i18n;
                  break;
              }
              return BarTooltipItem(
                weekDay + '\n',
                TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: (rod.y - 1).toString(),
                    style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            }),
        touchCallback: (barTouchResponse) {
          if (barTouchResponse.spot != null &&
              barTouchResponse.touchInput is! PointerUpEvent &&
              barTouchResponse.touchInput is! PointerExitEvent) {
            touchedIndex = barTouchResponse.spot.touchedBarGroupIndex;
          } else {
            touchedIndex = -1;
          }
          notifyListeners();
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          margin: 16,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return 'Mon'.i18n;
              case 1:
                return 'Tue'.i18n;
              case 2:
                return 'Wed'.i18n;
              case 3:
                return 'Thur'.i18n;
              case 4:
                return 'Fri'.i18n;
              case 5:
                return 'Sat'.i18n;
              case 6:
                return 'Sun'.i18n;
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = Colors.white,
    double width = 20,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 1 : y,
          colors: [barColor],
          width: width,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            colors: [
              AppColor.primaryColorDark.withOpacity(0.90).withAlpha(150)
            ],
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(7, (i) {
        return makeGroupData(i, weeklySales[i] ?? 0.00,
            isTouched: i == touchedIndex);
      });
}
