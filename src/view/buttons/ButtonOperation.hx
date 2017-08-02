package view.buttons;

import priori.event.PriTapEvent;
import priori.event.PriEvent;
import model.types.OperationsEnum;
import priori.event.PriMouseEvent;

class ButtonOperation extends Button {

    private var value:OperationsEnum;


    public function new(value:OperationsEnum) {
        super();

        this.value = value;
        this.text = Std.string(this.value);

        this.bgColor = 0xc9c9c9;
    }

    override private function onTap(e:PriTapEvent):Void {
        // dispatching a 'bubblelable' event
        var event:PriEvent = new PriEvent(Button.EVENT_BUTTON_OPERATION, false, true);
        event.data = this.value;

        this.dispatchEvent(event);
    }

    override private function onButtonOver(e:PriMouseEvent):Void {
        this.bgColor = 0xf9f9f9;
        super.onButtonOver(e);
    }

    override private function onButtonOut(e:PriMouseEvent):Void {
        this.bgColor = 0xc9c9c9;
        super.onButtonOut(e);
    }
}
