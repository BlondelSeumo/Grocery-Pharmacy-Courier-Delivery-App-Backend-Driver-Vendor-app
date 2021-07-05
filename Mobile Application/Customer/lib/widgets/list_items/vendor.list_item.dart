import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/models/vendor.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/widgets/buttons/route.button.dart';
import 'package:fuodz/widgets/custom_image.view.dart';
import 'package:fuodz/widgets/tags/close.tag.dart';
import 'package:fuodz/widgets/tags/delivery.tag.dart';
import 'package:fuodz/widgets/tags/open.tag.dart';
import 'package:fuodz/widgets/tags/pickup.tag.dart';
import 'package:velocity_x/velocity_x.dart';

class VendorListItem extends StatelessWidget {
  const VendorListItem({
    this.vendor,
    this.onPressed,
    Key key,
  }) : super(key: key);

  final Vendor vendor;
  final Function(Vendor) onPressed;
  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        //
        Stack(
          children: [
            //
            Hero(
              tag: vendor.heroTag,
              child: CustomImage(
                imageUrl: vendor.featureImage,
                height: Vx.dp64 * 2,
                width: context.percentWidth * 100,
              ),
            ),
            //location routing
            (vendor.latitude.isNotBlank && vendor.longitude.isNotBlank)
                ? Positioned(
                    child: RouteButton(vendor),
                    bottom: 10,
                    right: 10,
                  )
                : UiSpacer.emptySpace(),
          ],
        ),

        //
        //
        VStack(
          [
            //name
            vendor.name.text.xl.medium
                .maxLines(1)
                .overflow(TextOverflow.ellipsis)
                .make(),
            //description
            vendor.description.text.sm.light
                .maxLines(1)
                .overflow(TextOverflow.ellipsis)
                .make(),
            //rating
            VxRating(
              maxRating: 5.0,
              value: double.parse(vendor.rating.toString()),
              isSelectable: false,
              onRatingUpdate: null,
              selectionColor: AppColor.ratingColor,
            ),
          ],
        ).p8(),

        //tags
        HStack(
          [
            //is open
            vendor.isOpen
                ? OpenTag().pOnly(right: 10)
                : CloseTag().pOnly(right: 10),

            //can deliver
            vendor.delivery == 1
                ? DeliveryTag().pOnly(right: 10)
                : UiSpacer.emptySpace(),

            //can pickup
            vendor.pickup == 1
                ? PickupTag().pOnly(right: 10)
                : UiSpacer.emptySpace(),
          ],
        ).p8(),
      ],
    )
        .onInkTap(
          () => this.onPressed(this.vendor),
        )
        .wThreeForth(context)
        .card
        .clip(Clip.antiAlias)
        .roundedSM
        .make();
  }


}
