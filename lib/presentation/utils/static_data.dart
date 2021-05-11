import 'package:flutask/data/models/models.dart';

import 'constants.dart';

class StaticData {
  static List<OnBoardModel> getOnBoardingList() => [
        OnBoardModel(
            title: 'Manage Your Tasks',
            illustration: Resources.on_board_1,
            description:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi diam mauris, vulputate eu elit malesuada, tincidunt fermentum purus.'),
        OnBoardModel(
            title: 'Do All The Tasks',
            illustration: Resources.on_board_2,
            description:
                'Donec sed velit faucibus, ornare nulla id, luctus sapien. Pellentesque molestie pulvinar eros ultrices egestas. Fusce bibendum aliquet lectus quis congue.'),
        OnBoardModel(
            title: 'Complete Your Tasks',
            illustration: Resources.on_board_3,
            description:
                'Aliquam commodo mattis massa id tristique. Sed euismod quam enim, vulputate placerat mauris ornare nec.'),
      ];
}
