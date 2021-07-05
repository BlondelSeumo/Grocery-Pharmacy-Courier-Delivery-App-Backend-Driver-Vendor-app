import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:fuodz/constants/app_images.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/services/validator.service.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/register.view_model.dart';
import 'package:fuodz/widgets/base.page.dart';
import 'package:fuodz/widgets/buttons/custom_button.dart';
import 'package:fuodz/widgets/custom_text_form_field.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/register.i18n.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegisterViewModel>.reactive(
      viewModelBuilder: () => RegisterViewModel(context),
      onModelReady: (model) => model.initialise(),
      builder: (context, model, child) {
        return BasePage(
          showLeadingAction: true,
          showAppBar: true,
          body: SafeArea(
            top: true,
            bottom: false,
            child: Padding(
              padding: EdgeInsets.only(bottom: context.mq.viewInsets.bottom),
              child: VStack(
                [
                  Image.asset(
                    AppImages.onboarding2,
                  ).hOneForth(context).centered(),
                  //
                  VStack(
                    [
                      //
                      "Join Us".i18n.text.xl2.semiBold.make(),
                      "Create an account now".i18n.text.light.make(),

                      //form
                      Form(
                        key: model.formKey,
                        child: VStack(
                          [
                            //
                            CustomTextFormField(
                              labelText: "Name".i18n,
                              textEditingController: model.nameTEC,
                              validator: FormValidator.validateName,
                            ).py12(),
                            //
                            CustomTextFormField(
                              labelText: "Email",
                              keyboardType: TextInputType.emailAddress,
                              textEditingController: model.emailTEC,
                              validator: FormValidator.validateEmail,
                            ).py12(),
                            //
                            HStack(
                              [
                                CustomTextFormField(
                                  prefixIcon: CountryCodePicker(
                                    dialogBackgroundColor: context.backgroundColor,
                                    showCountryOnly: true,
                                    initialSelection: AppStrings.countryCode,
                                    flagWidth: 16,
                                    padding: EdgeInsets.all(0),
                                    onChanged: model.countryCodeSelected,
                                    onInit: model.countryCodeSelected,
                                  ),
                                  labelText: "Phone".i18n,
                                  hintText: "",
                                  keyboardType: TextInputType.phone,
                                  textEditingController: model.phoneTEC,
                                  validator: FormValidator.validatePhone,
                                ).expand(),
                              ],
                            ).py12(),
                            //
                            CustomTextFormField(
                              labelText: "Password".i18n,
                              obscureText: true,
                              textEditingController: model.passwordTEC,
                              validator: FormValidator.validatePassword,
                            ).py12(),
                            //
                            AppStrings.enableReferSystem
                                ? CustomTextFormField(
                                    labelText: "Referral Code(optional)".i18n,
                                    textEditingController:
                                        model.referralCodeTEC,
                                  ).py12()
                                : UiSpacer.emptySpace(),

                            //
                            CustomButton(
                              title: "Create Account".i18n,
                              loading: model.isBusy,
                              onPressed: model.processRegister,
                            ).centered().py12(),

                            //register
                            "OR".i18n.text.light.makeCentered(),
                            "Already have an Account"
                                .i18n
                                .text
                                .semiBold
                                .makeCentered()
                                .py12()
                                .onInkTap(model.openLogin),
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
          ),
        );
      },
    );
  }
}
