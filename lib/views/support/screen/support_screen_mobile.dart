part of 'support_screen.dart';

class SupportScreenMobile extends GetView<SupportController> {
  const SupportScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "Contact & Support"),
      body: SafeArea(
        child: Form(
          key: controller.formKey,
          child: ListView(
            padding: Dimensions.defaultHorizontalSize.edgeHorizontal,
            children: [
              Space.height.betweenInputBox,
              PrimaryInputFieldWidget(
                controller: controller.nameController,
                hintText: 'Enter Your Name',
                label: 'Name',
              ),
              Space.height.betweenInputBox,
              PrimaryInputFieldWidget(
                controller: controller.emailController,
                hintText: 'Enter Your Email',
                label: 'Email',
                isEmail: true,
              ),
              Space.height.betweenInputBox,
              PrimaryInputFieldWidget(
                controller: controller.messageController,
                hintText: 'Write here',
                label: 'Message',
                maxLines: 5,
              ),
              Space.height.betweenInputBox,
              Obx(
                    () => GestureDetector(
                  onTap: () => BottomImagePicker.show(
                    singleImageVariable: (image) {
                      controller.attachment.value = image;
                      return null;
                    },
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.defaultHorizontalSize,
                      vertical: Dimensions.verticalSize * 0.6,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius),
                      border: Border.all(
                        color: controller.attachment.value != null
                            ? CustomColors.primary
                            : CustomColors.borderColor,
                        width: 1.4,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.attach_file,
                          color: controller.attachment.value != null
                              ? CustomColors.primary
                              : CustomColors.disableColor,
                        ),
                        Space.width.v10,
                        Expanded(
                          child: TextWidget(
                            controller.attachment.value != null
                                ? controller.attachment.value!.name
                                : 'Add Attachment (Optional)',
                            fontSize: Dimensions.titleSmall * 1.1,
                            color: controller.attachment.value != null
                                ? CustomColors.blackColor
                                : CustomColors.disableColor,
                            fontWeight: FontWeight.w500,
                            textOverflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        if (controller.attachment.value != null)
                          GestureDetector(
                            onTap: () => controller.attachment.value = null,
                            child: Icon(
                              Icons.close,
                              color: CustomColors.rejected,
                              size: Dimensions.iconSizeDefault,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              Space.height.betweenInputBox,
              Obx(
                    () => PrimaryButtonWidget(
                  isLoading: controller.isLoading.value,
                  title: "Submit",
                  onPressed: () {
                    if(controller.formKey.currentState!.validate()){
                      controller.sendSupport();
                    }
                  }
                ),
              ),
              Space.height.betweenInputBox,
            ],
          ),
        ),
      ),
    );
  }
}