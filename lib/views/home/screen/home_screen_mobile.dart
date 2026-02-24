part of 'home_screen.dart';

class HomeScreenMobile extends GetView<HomeController> {
  const HomeScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        flexibleSpace: MyAppBarWidget(),
      ),
      body: SafeArea(
        child: Obx(
          () => controller.isLoading.value ? LoadingWidget() : _bodyWidget(),
        ),
      ),
    );
  }

  CustomScrollView _bodyWidget() {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      slivers: [
        SliverToBoxAdapter(child: Space.height.v20),
        const SliverToBoxAdapter(child: SearchHeaderWidget()),
        const SliverToBoxAdapter(child: SliderItemWidget()),

        if (controller.wellnessTipsList.isNotEmpty) ...[
          SliverToBoxAdapter(
            child: SectionHeader(
              title: "Daily Wellness Tips",
              onViewAllTap: () => Get.toNamed(Routes.tipsScreen),
            ),
          ),
          SliverToBoxAdapter(child: TipsCardWidget()),
        ],

        SliverToBoxAdapter(
          child: SectionHeader(
            title: "Popular Specialties",
            onViewAllTap: () => Get.toNamed(Routes.allCategoryScreen),
          ),
        ),
        const SliverToBoxAdapter(child: CategorySectionWidget()),

        SliverToBoxAdapter(
          child: SectionHeader(
            title: "Popular Doctor",
            onViewAllTap: () => Get.toNamed(Routes.allDoctorsScreen),
          ),
        ),
        const SliverToBoxAdapter(child: HomeDoctorCardWidget()),

        const SliverToBoxAdapter(child: BottomBannerWidget()),
      ],
    );
  }
}
