package view.buttons;

import priori.event.PriEvent;
import priori.event.PriTapEvent;
import priori.event.PriMouseEvent;
import model.types.DigitsEnum;

class ButtonDigit extends Button {

    private var value:DigitsEnum;


    public function new(value:DigitsEnum) {
        super();

        this.value = value;
        this.text = Std.string(this.value);

        this.bgColor = 0xe9e9e9;
    }

    override private function onTap(e:PriTapEvent):Void {
        // dispatching a 'bubblelable' event
        var event:PriEvent = new PriEvent(Button.EVENT_BUTTON_DIGIT, false, true);
        event.data = this.value;

        this.dispatchEvent(event);
    }


    override private function onButtonOver(e:PriMouseEvent):Void {
        this.bgColor = 0xf9f9f9;
        super.onButtonOver(e);
    }

    override private function onButtonOut(e:PriMouseEvent):Void {
        this.bgColor = 0xe9e9e9;
        super.onButtonOut(e);
    }
}
