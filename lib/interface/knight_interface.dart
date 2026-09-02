import 'package:bonfire/bonfire.dart';
import 'package:shadow_depths/interface/bar_life_component.dart';
import 'package:shadow_depths/player/knight.dart';

class KnightInterface extends GameInterface {
  late Sprite keySprite;

  @override
  Future<void> onLoad() async {
    keySprite = await Sprite.load('items/key_silver.png');
    add(MyBarLifeComponent());
    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    try {
      _drawKey(canvas);
    } catch (e) {}
    super.render(canvas);
  }

  void _drawKey(Canvas c) {
    if (gameRef.player != null && (gameRef.player as Knight).containKey) {
      keySprite.renderRect(c, Rect.fromLTWH(150, 20, 35, 30));
    }
  }
}
