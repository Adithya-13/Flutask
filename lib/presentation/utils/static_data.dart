import 'constants.dart';

class OnBoard {
  final int id;
  final String title;
  final String illustration;
  final String description;

  OnBoard({
    required this.id,
    required this.title,
    required this.illustration,
    required this.description,
  });
}

class StaticData {
  static List<OnBoard> getOnBoardingList() => [
        OnBoard(
          id: 0,
          title: 'Manage Your Tasks',
          illustration: Resources.on_board_1,
          description:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi diam mauris, vulputate eu elit malesuada, tincidunt fermentum purus.',
        ),
        OnBoard(
          id: 1,
          title: 'Do All The Tasks',
          illustration: Resources.on_board_2,
          description:
              'Donec sed velit faucibus, ornare nulla id, luctus sapien. Pellentesque molestie pulvinar eros ultrices egestas. Fusce bibendum aliquet lectus quis congue.',
        ),
        OnBoard(
          id: 2,
          title: 'Complete Your Tasks',
          illustration: Resources.on_board_3,
          description:
              'Aliquam commodo mattis massa id tristique. Sed euismod quam enim, vulputate placerat mauris ornare nec.',
        ),
      ];
}
