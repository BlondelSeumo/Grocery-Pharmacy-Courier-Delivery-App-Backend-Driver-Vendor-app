import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_images.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/services/validator.service.dart';

import 'package:fuodz/view_models/forgot_password.view_model.dart';
import 'package:fuodz/widgets/base.page.dart';
import 'package:fuodz/widgets/buttons/custom_button.dart';
import 'package:fuodz/widgets/custom_text_form_field.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/forgot_password.i18n.dart';

class ForgotPasswordPage extends StatefulWidget {
  ForgotPasswordPage({Key key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ForgotPasswordViewModel>.reactive(
      viewModelBuilder: () => ForgotPasswordViewModel(context),
      onModelReady: (model) => model.initialise(),
      builder: (context, model, child) {
        return BasePage(
          showLeadingAction: true,
          showAppBar: true,
          body: SafeArea(
            top: true,
            bottom: false,
            child: VStack(
              [
                Image.asset(
                  AppImages.onboarding1,
                ).hOneForth(context).centered(),
                //
                VStack(
                  [
                    //
                    "Forgot Password".i18n.text.xl2.semiBold.make(),

                    //form
                    Form(
                      key: model.formKey,
                      child: VStack(
                        [
                          //
                          CustomTextFormField(
                            prefixIcon: CountryCodePicker(
                              showCountryOnly: true,
                              initialSelection: AppStrings.countryCode,
                              flagWidth: 16,
                              padding: EdgeInsets.all(0),
                              onChanged: model.countryCodeSelected,
                              onInit: model.countryCodeSelected,
                            ),
                            labelText: "Phone Number".i18n,
                            hintText: "",
                            keyboardType: TextInputType.phone,
                            textEditingController: model.phoneTEC,
                            validator: FormValidator.validatePhone,
                          ).py12(),
                          //
                          CustomButton(
                            title: "Send OTP".i18n,
                            loading: model.isBusy,
                            onPressed: model.processForgotPassword,
                          ).h(Vx.dp48).centered().py12(),
                        ],
                        crossAlignment: CrossAxisAlignment.end,
                      ),
                    ).py20(),
                  ],
                ).wFull(context).p20(),

                //
              ],
            ).scrollVertical(),
          ),
        );
      },
    );
  }
}
