package view.buttons;

import priori.app.PriApp;
import priori.style.shadow.PriShadowStyle;
import priori.event.PriTapEvent;
import motion.Actuate;
import priori.event.PriMouseEvent;
import priori.style.font.PriFontStyleAlign;
import priori.style.font.PriFontStyle;
import priori.view.form.PriFormButton;

class Button extends PriFormButton {

    public static var EVENT_BUTTON_DIGIT:String = "EVENT_BUTTON_DIGIT";
    public static var EVENT_BUTTON_OPERATION:String = "EVENT_BUTTON_OPERATION";
    public static var EVENT_BUTTON_SYMBOL:String = "EVENT_BUTTON_SIMBOL";

    private var overShadow:PriShadowStyle;

    public function new() {
        super();

        this.fontStyle = new PriFontStyle().setColor(0x666666).setAlign(PriFontStyleAlign.CENTER);
        this.fontSize = 22;

        this.overShadow = new PriShadowStyle()
        .setHorizontalOffset(0)
        .setVerticalOffset(1)
        .setBlur(2)
        .setSpread(0.5)
        .setColor(0x000000)
        .setOpacity(0.0);

        this.addEventListener(PriMouseEvent.MOUSE_OVER, this.onButtonOver);
        this.addEventListener(PriMouseEvent.MOUSE_OUT, this.onButtonOut);
        this.addEventListener(PriTapEvent.TAP_DOWN, this.onTapDown);
        this.addEventListener(PriTapEvent.TAP_DOWN, this.onTap);

        this.anchorX = 0.5;
        this.anchorY = 0.5;
    }

    private function onTap(e:PriTapEvent):Void {

    }

    private function onTapDown(e:PriTapEvent):Void {
        this.removeEventListener(PriTapEvent.TAP_DOWN, this.onTapDown);
        PriApp.g().addEventListener(PriTapEvent.TAP_UP, this.onTapUp);

        this.scaleX = 0.95;
        this.scaleY = 0.95;
    }

    private function onTapUp(e:PriTapEvent):Void {
        this.addEventListener(PriTapEvent.TAP_DOWN, this.onTapDown);
        PriApp.g().removeEventListener(PriTapEvent.TAP_UP, this.onTapUp);

        Actuate.tween(
            this,
            0.2,
            {
                scaleX : 1,
                scaleY : 1
            }
        ).ease(
            motion.easing.Cubic.easeOut
        );
    }

    private function onButtonOver(e:PriMouseEvent):Void {
        Actuate.tween(
            this.overShadow,
            0.2,
            {
                opacity : 0.1
            }
        ).onUpdate(
            function():Void this.shadow = [this.overShadow]
        ).ease(
            motion.easing.Cubic.easeIn
        );
    }

    private function onButtonOut(e:PriMouseEvent):Void {
        Actuate.tween(
            this.overShadow,
            0.2,
            {
                opacity : 0.0
            }
        ).onUpdate(
            function():Void this.shadow = [this.overShadow]
        ).ease(
            motion.easing.Cubic.easeOut
        );
    }
}
