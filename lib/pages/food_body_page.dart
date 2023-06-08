import 'package:dots_indicator/dots_indicator.dart';
import 'package:ecommerce/utils/dimensions.dart';
import 'package:ecommerce/widgets/subtitle_text.dart';
import 'package:ecommerce/widgets/text_and_icon.dart';
import 'package:ecommerce/widgets/title_text.dart';
import 'package:flutter/material.dart';

class FoodBodyPage extends StatefulWidget {
  const FoodBodyPage({super.key});

  @override
  State<FoodBodyPage> createState() => _FoodBodyState();
}

class _FoodBodyState extends State<FoodBodyPage> {
  final PageController _controller = PageController(viewportFraction: .85);
  double scaleFactor = 0.8;
  double _currentPage = 0.0;
  final double _height = Dimen.pageViewController;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _currentPage = _controller.page!;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: Dimen.pageView,
        child: PageView.builder(
          controller: _controller,
          itemBuilder: (context, index) {
            return _buildPageItem(index);
          },
          itemCount: 5,
        ),
      ),
      DotsIndicator(
        dotsCount: 5,
        position: _currentPage.floor(),
        decorator: DotsDecorator(
            activeColor: Colors.greenAccent,
            size: const Size.square(8.0),
            activeSize: const Size(16.0, 8.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15))),
      ),
      Container(
        margin: const EdgeInsets.only(top: 15, left: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TitleText(text: "Popular"),
            const SizedBox(width: 10),
            Container(
              margin: const EdgeInsets.only(bottom: 3),
              child: TitleText(
                text: ".",
                textColor: Colors.grey,
              ),
            ),
            const SizedBox(width: 10),
            Container(
              margin: const EdgeInsets.only(top: 3),
              child: SubTitleText(
                text: "Food paring",
                fontColor: Colors.grey,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
      _buildListView(),
    ]);
  }

  Widget _buildPageItem(int index) {
    return Transform(
      transform: _getCalculatedMatrix(index, _currentPage),
      child: Stack(
        children: [
          Container(
            height: _height,
            margin: const EdgeInsets.only(left: 5, right: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: index.isEven ? Colors.blueAccent : Colors.green,
                image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/food1.png"))),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 110,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                        color: Color.fromARGB(255, 212, 212, 212),
                        offset: Offset(0, 5),
                        blurRadius: 3.0),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-5, 0),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(5, 0),
                    ),
                  ]),
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: _foodCardDetails(),
            ),
          )
        ],
      ),
    );
  }

  Widget _foodCardDetails() {
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleText(
            text: "Bitter Orange Marinade",
            fontSize: 16,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Wrap(
                children: List.generate(
                    5,
                    (index) => const Icon(
                          Icons.star,
                          size: 15,
                          color: Colors.greenAccent,
                        )),
              ),
              const SizedBox(
                width: 10,
              ),
              SubTitleText(text: '4.5'),
              SizedBox(
                width: Dimen.height10,
              ),
              SubTitleText(text: '1287 comments'),
            ],
          ),
          SizedBox(
            height: Dimen.height10,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextAndIcon(
                  iconData: Icons.circle_sharp,
                  text: "Normal",
                  iconColor: Colors.orange),
              TextAndIcon(
                  iconData: Icons.location_on,
                  text: "1.7km",
                  iconColor: Colors.green),
              TextAndIcon(
                  iconData: Icons.access_time_rounded,
                  text: "32min",
                  iconColor: Colors.orange),
            ],
          )
        ],
      ),
    );
  }

  Matrix4 _getCalculatedMatrix(int index, double currPage) {
    Matrix4 matrix = Matrix4.identity();
    var scaleFactor = 0.8;
    if (index == currPage.floor()) {
      var currScale = 1 - (currPage - index) * (1 - scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == currPage.floor() + 1) {
      var currScale = scaleFactor + (currPage - index + 1) * (1 - scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == currPage.floor() - 1) {
      var currScale = 1 - (currPage - index) * (1 - scaleFactor);
      var currTrans = _height * (1 - scaleFactor) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      var currTrans = _height * (1 - scaleFactor) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 1);
    }
    return matrix;
  }

  Widget _buildListView() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(
              left: Dimen.height20,
              right: Dimen.height20,
              bottom: Dimen.height10),
          child: Row(
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(15),
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/food1.png"),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 85,
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TitleText(text: "Nutritious fruit meal in China"),
                      SubTitleText(
                        text: "with chinese characteristics",
                        fontColor: Colors.grey,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextAndIcon(
                              iconData: Icons.circle_sharp,
                              text: "Normal",
                              iconColor: Colors.orange),
                          TextAndIcon(
                              iconData: Icons.location_on,
                              text: "1.7km",
                              iconColor: Colors.green),
                          TextAndIcon(
                              iconData: Icons.access_time_rounded,
                              text: "32min",
                              iconColor: Colors.orange),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
