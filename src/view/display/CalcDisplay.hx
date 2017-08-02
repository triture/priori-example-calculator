package view.display;

import model.types.SymbolsEnum;
import priori.view.text.PriText;
import priori.view.container.PriGroup;
import priori.style.font.PriFontStyle;
import priori.style.shadow.PriShadowPresets;
import priori.style.border.PriBorderStyle;

class CalcDisplay extends PriGroup {

    private var historyValue:PriText;
    private var currentInputValue:PriText;

    public function new() {
        super();

        this.height = 105;
    }

    public function getValue():Float {
        return Std.parseFloat(this.currentInputValue.text);
    }

    public function setHistory(value:String):Void {
        this.historyValue.text = value;

        this.invalidate();
        this.validate();
    }

    public function setValue(value:Float):Void {
        this.currentInputValue.text = Std.string(value);

        this.invalidate();
        this.validate();
    }

    public function addDigit(digit:String):Void {
        var curDigits:String = this.currentInputValue.text;

        // no more than FLOAT_PRECISION digits
        var maxDigits:Int = Calculator.FLOAT_PRECISION + 1; // plus one for integer part
        var hasFloatPoint:Bool = (curDigits.indexOf(SymbolsEnum.FLOAT) > -1);

        if (hasFloatPoint) maxDigits += 1;

        if (curDigits.length >= maxDigits) return;

        if (curDigits == "0") {
            if (digit == SymbolsEnum.FLOAT) {
                curDigits = "0.";
            } else curDigits = digit;
        } else {
            if (digit == SymbolsEnum.FLOAT) {

                // verify if float point exists
                if (curDigits.indexOf(SymbolsEnum.FLOAT) == -1) curDigits += digit;

            } else curDigits += digit;

        }


        // update digits display
        this.currentInputValue.text = curDigits;

        // repaint
        this.revalidate();
    }

    override private function setup():Void {
        this.bgColor = 0xFFFFFF;
        this.border = new PriBorderStyle(1, 0xCCCCCC);
        this.shadow = PriShadowPresets.SIMPLE_INNER_SHADOW;
        this.corners = [3];

        this.currentInputValue = new PriText();
        this.currentInputValue.fontStyle = new PriFontStyle().setColor(0x333333);
        this.currentInputValue.fontSize = 68;
        this.currentInputValue.text = "0";
        this.currentInputValue.anchorX = 0;
        this.currentInputValue.anchorY = 0;
        this.currentInputValue.selectable = true;

        this.historyValue = new PriText();
        this.historyValue.fontStyle = new PriFontStyle().setColor(0x999999);
        this.historyValue.fontSize = 14;
        this.historyValue.text = "";

        this.addChildList(
            [
                this.historyValue,
                this.currentInputValue
            ]
        );
    }

    override private function paint():Void {
        var space:Int = 10;

        this.historyValue.maxX = this.width - space;
        this.historyValue.y = space;

        // reset text display scale
        this.currentInputValue.scaleX = this.currentInputValue.scaleY = 1;

        if (this.currentInputValue.width > this.width - space*2) {
            this.currentInputValue.widthScaled = this.width - space*2;
            this.currentInputValue.scaleY = this.currentInputValue.scaleX;
        }

        this.currentInputValue.maxX = this.width - space;

        this.currentInputValue.centerY = this.historyValue.maxY + (this.height - this.historyValue.maxY)/2;
    }

}
