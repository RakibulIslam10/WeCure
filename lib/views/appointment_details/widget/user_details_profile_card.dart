import '../../../core/utils/basic_import.dart';

class PatientInfoWidgetWithAsset extends StatelessWidget {
  final String? patientImageAsset;
  final String? patientImageNetwork;
  final String patientName;
  final String dateOfBirth;
  final String phoneNumber;
  final String bloodGroup;
  final List<String> allergies;

  const PatientInfoWidgetWithAsset({
    super.key,
    this.patientImageAsset,
    this.patientImageNetwork,
    required this.patientName,
    required this.dateOfBirth,
    required this.phoneNumber,
    this.bloodGroup = "A+",
    required this.allergies,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: CustomColors.whiteColor,
        border: Border.all(color: CustomColors.borderColor),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                width: 80.w,
                height: 80.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: CustomColors.borderColor,
                ),
                clipBehavior: Clip.antiAlias,
                child: _buildImage(),
              ),

              SizedBox(width: 12.w),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextWidget(
                      patientName,
                      fontSize: Dimensions.titleLarge,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(height: 4.h),
                    TextWidget(
                      dateOfBirth,
                      color: CustomColors.blackColor.withOpacity(0.6),
                      fontSize: Dimensions.titleSmall,
                    ),
                    SizedBox(height: 2.h),
                    TextWidget(
                      phoneNumber,
                      color: CustomColors.blackColor.withOpacity(0.6),
                      fontSize: Dimensions.titleSmall,
                    ),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: CustomColors.grayShade.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: TextWidget(
                  bloodGroup,
                  color: CustomColors.primary,
                  fontSize: Dimensions.titleMedium,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          TextWidget(
            "Allergies:",
            fontSize: Dimensions.titleMedium,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: 8.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: allergies.map((allergy) {
              return _AllergyChip(label: allergy);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    if (patientImageAsset != null) {
      return Image.asset(
        patientImageAsset!,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
      );
    } else if (patientImageNetwork != null) {
      return Image.network(
        patientImageNetwork!,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
      );
    }
    return _buildPlaceholder();
  }

  Widget _buildPlaceholder() {
    return Container(
      color: CustomColors.offWhite,
      child: Icon(
        Icons.person,
        size: 40.sp,
        color: CustomColors.blackColor.withOpacity(0.3),
      ),
    );
  }
}

class _AllergyChip extends StatelessWidget {
  final String label;

  const _AllergyChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: CustomColors.offWhite,
        border: Border.all(color: CustomColors.borderColor),
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: TextWidget(
        label,
        fontSize: Dimensions.titleSmall * 0.8,
        color: CustomColors.blackColor.withOpacity(0.7),
      ),
    );
  }
}
