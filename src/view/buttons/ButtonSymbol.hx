package view.buttons;

import priori.event.PriEvent;
import priori.event.PriTapEvent;
import model.types.SymbolsEnum;
import priori.event.PriMouseEvent;

class ButtonSymbol extends Button {

    private var value:SymbolsEnum;


    public function new(value:SymbolsEnum) {
        super();

        this.value = value;
        this.text = Std.string(this.value);

        this.bgColor = 0xd9d9d9;
    }

    override private function onTap(e:PriTapEvent):Void {
        // dispatching a 'bubblelable' event
        var event:PriEvent = new PriEvent(Button.EVENT_BUTTON_SYMBOL, false, true);
        event.data = this.value;

        this.dispatchEvent(event);
    }

    override private function onButtonOver(e:PriMouseEvent):Void {
        this.bgColor = 0xf9f9f9;
        super.onButtonOver(e);
    }

    override private function onButtonOut(e:PriMouseEvent):Void {
        this.bgColor = 0xd9d9d9;
        super.onButtonOut(e);
    }
}
