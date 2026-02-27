import '../utils/basic_import.dart';

class PaginationLoaderWidget extends StatelessWidget {
  final int index;
  final RxList list;
  final RxInt currentPage;
  final VoidCallback fetchFunction;
  final EdgeInsetsGeometry? padding;

  const PaginationLoaderWidget({
    super.key,
    required this.index,
    required this.list,
    required this.currentPage,
    required this.fetchFunction,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    if (index != list.length) return const SizedBox.shrink();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      currentPage.value++;
      fetchFunction();
    });

    return Center(
      child: Padding(
        padding: padding ?? EdgeInsets.symmetric(vertical: Dimensions.paddingSize * 0.5),
        child: CircularProgressIndicator(color: CustomColors.primary),
      ),
    );
  }
}