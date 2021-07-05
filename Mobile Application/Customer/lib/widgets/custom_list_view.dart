import 'package:flutter/material.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/widgets/states/empty.state.dart';
import 'package:fuodz/widgets/states/loading.shimmer.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomListView extends StatelessWidget {
  //
  final ScrollController scrollController;
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

  //
  final bool canRefresh;
  final RefreshController refreshController;
  final Function onRefresh;
  final Function onLoading;
  final bool canPullUp;

  const CustomListView({
    @required this.dataSet,
    this.scrollController,
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
    final contentBody = this.isLoading
        ? this.loadingWidget ?? LoadingShimmer()
        : this.hasError
            ? this.errorWidget ?? EmptyState(description: "There is an error")
            : this.dataSet.isEmpty
                ? this.emptyWidget ?? UiSpacer.emptySpace()
                : this.justList
                    ? _getListView()
                    : Expanded(
                        child: _getListView(),
                      );

    return this.canRefresh
        ? SmartRefresher(
            scrollDirection: this.scrollDirection,
            enablePullDown: true,
            enablePullUp: canPullUp,
            controller: this.refreshController,
            onRefresh: this.onRefresh,
            onLoading: this.onLoading,
            child: contentBody,
          )
        : contentBody;
  }

  //get listview
  Widget _getListView() {
    return ListView.separated(
      controller: this.scrollController,
      padding: this.padding,
      shrinkWrap: true,
      reverse: this.reversed,
      physics: this.noScrollPhysics ? NeverScrollableScrollPhysics() : null,
      scrollDirection: this.scrollDirection,
      itemBuilder: this.itemBuilder,
      itemCount: this.dataSet.length,
      separatorBuilder: this.separatorBuilder ??
          (context, index) => this.scrollDirection == Axis.vertical
              ? UiSpacer.verticalSpace()
              : UiSpacer.horizontalSpace(),
    );
  }
}
