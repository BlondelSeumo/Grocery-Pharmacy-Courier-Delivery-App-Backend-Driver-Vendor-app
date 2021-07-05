import 'package:flutter/material.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/widgets/states/empty.state.dart';
import 'package:fuodz/widgets/states/loading.shimmer.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomGridView extends StatelessWidget {
  //
  final Widget title;
  final Widget loadingWidget;
  final Widget errorWidget;
  final Widget emptyWidget;
  final List<dynamic> dataSet;
  final bool isLoading;
  final bool hasError;
  final bool justList;
  final bool reversed;
  final bool noScrollPhysics;
  final Axis scrollDirection;
  final EdgeInsets padding;
  final Function(BuildContext, int) itemBuilder;
  final Function(BuildContext, int) separatorBuilder;
  final int crossAxisCount;
  final double childAspectRatio;
  final double crossAxisSpacing;
  final double mainAxisSpacing;

  //
  final bool canRefresh;
  final RefreshController refreshController;
  final Function onRefresh;
  final Function onLoading;
  final bool canPullUp;

  const CustomGridView({
    @required this.dataSet,
    this.title,
    this.loadingWidget,
    this.errorWidget,
    this.emptyWidget,
    this.isLoading = false,
    this.hasError = false,
    this.justList = true,
    this.reversed = false,
    this.noScrollPhysics = false,
    this.scrollDirection = Axis.vertical,
    @required this.itemBuilder,
    this.separatorBuilder,
    this.padding,
    this.crossAxisCount = 2,
    this.childAspectRatio = 1.0,
    this.crossAxisSpacing = 2,
    this.mainAxisSpacing = 0,

    //
    this.canRefresh = false,
    this.refreshController,
    this.onRefresh,
    this.onLoading,
    this.canPullUp = false,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return this.justList
        ? _getBody()
        : VStack(
            [
              this.title ?? UiSpacer.emptySpace(),
              _getBody(),
            ],
            crossAlignment: CrossAxisAlignment.start,
          );
  }

  Widget _getBody() {
    return this.isLoading
        ? this.loadingWidget ?? LoadingShimmer()
        : this.hasError
            ? this.errorWidget ?? EmptyState()
            : this.justList
                ? this.dataSet.isEmpty
                    ? this.emptyWidget ?? UiSpacer.emptySpace()
                    : _getBodyList()
                : Expanded(
                    child: _getBodyList(),
                  );
  }

  //
  Widget _getBodyList() {
    return this.canRefresh
        ? SmartRefresher(
            scrollDirection: this.scrollDirection,
            enablePullDown: true,
            enablePullUp: canPullUp,
            controller: this.refreshController,
            onRefresh: this.onRefresh,
            onLoading: this.onLoading,
            child: _getListView(),
          )
        : _getListView();
  }

  //get listview
  Widget _getListView() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: this.crossAxisCount,
        childAspectRatio: this.childAspectRatio,
        crossAxisSpacing: this.crossAxisSpacing,
        mainAxisSpacing: this.mainAxisSpacing,
      ),
      padding: this.padding,
      physics: this.noScrollPhysics ? NeverScrollableScrollPhysics() : null,
      shrinkWrap: true,
      itemBuilder: this.itemBuilder,
      itemCount: this.dataSet.length,
      reverse: this.reversed,
      scrollDirection: this.scrollDirection,
    );
  }
}
