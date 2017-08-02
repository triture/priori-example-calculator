package view;

import view.buttons.ButtonSymbol;
import view.buttons.ButtonOperation;
import view.buttons.ButtonDigit;
import view.buttons.Button;
import view.display.CalcDisplay;
import model.types.SymbolsEnum;
import model.types.OperationsEnum;
import model.types.DigitsEnum;
import priori.view.container.PriGroup;
import priori.event.PriEvent;
import priori.style.shadow.PriShadowPresets;
import priori.style.border.PriBorderStyle;

class Calculator extends PriGroup {

    public static var FLOAT_PRECISION:Int = 7;

    private var display:CalcDisplay;
    private var buttons:Array<Button> = [];

    private var currentValue:Float = null;
    private var currentOperation:OperationsEnum = null;

    private var mustClear:Bool = true;

    public function new() {
        super();
    }

    override private function setup():Void {
        this.bgColor = 0xf4f4f4;
        this.border = new PriBorderStyle(2, 0xDDDDDD);
        this.corners = [4];
        this.shadow = PriShadowPresets.APPLE_SHADOW;


        this.display = new CalcDisplay();

        this.buttons.push(new ButtonDigit(DigitsEnum.N7));
        this.buttons.push(new ButtonDigit(DigitsEnum.N8));
        this.buttons.push(new ButtonDigit(DigitsEnum.N9));
        this.buttons.push(new ButtonOperation(OperationsEnum.DIVIDE));

        this.buttons.push(new ButtonDigit(DigitsEnum.N4));
        this.buttons.push(new ButtonDigit(DigitsEnum.N5));
        this.buttons.push(new ButtonDigit(DigitsEnum.N6));
        this.buttons.push(new ButtonOperation(OperationsEnum.MULTIPLY));

        this.buttons.push(new ButtonDigit(DigitsEnum.N1));
        this.buttons.push(new ButtonDigit(DigitsEnum.N2));
        this.buttons.push(new ButtonDigit(DigitsEnum.N3));
        this.buttons.push(new ButtonOperation(OperationsEnum.MINUS));

        this.buttons.push(new ButtonDigit(DigitsEnum.N0));
        this.buttons.push(new ButtonSymbol(SymbolsEnum.FLOAT));
        this.buttons.push(new ButtonSymbol(SymbolsEnum.EQUAL));
        this.buttons.push(new ButtonOperation(OperationsEnum.PLUS));


        this.addChildList(
            [
                this.display
            ]
        );

        this.addChildList(this.buttons);

        this.addEventListener(Button.EVENT_BUTTON_DIGIT, this.onButtonDigitEvent);
        this.addEventListener(Button.EVENT_BUTTON_SYMBOL, this.onButtonSymbolEvent);
        this.addEventListener(Button.EVENT_BUTTON_OPERATION, this.onButtonOperation);
    }

    // this is how to render the components
    override private function paint():Void {
        var space:Int = 10;

        this.display.x = space;
        this.display.y = space;
        this.display.width = this.width - space*2;

        var cols:Int = 4;
        var rows:Int = (this.buttons.length % cols == 0) ? Math.floor((this.buttons.length / cols)) : Math.floor((this.buttons.length / cols)) + 1;
        var width:Float = this.width;
        var height:Float = this.height - this.display.height - space;

        var itemWidth:Float = (width - ((cols + 1) * space)) / cols;
        var itemHeight:Float = (height - ((rows + 1) * space)) / rows;

        var initialX:Float = 0;
        var initialY:Float = this.display.maxY;

        for (i in 0 ... this.buttons.length) {
            if (this.buttons[i] != null) {

                this.buttons[i].width = itemWidth;
                this.buttons[i].height = itemHeight;

                this.buttons[i].x = initialX + space + (i%cols) * (itemWidth + space);
                this.buttons[i].y = initialY + space + Math.floor(i/cols) * (itemHeight + space);
            }
        }
    }

    private function onButtonDigitEvent(e:PriEvent):Void {
        e.stopBubble();

        var data:DigitsEnum = e.data;
        if (this.mustClear) this.clearCalculator();

        this.display.addDigit(Std.string(data));
    }

    private function onButtonSymbolEvent(e:PriEvent):Void {
        e.stopBubble();

        var data:SymbolsEnum = e.data;
        if (this.mustClear) this.clearCalculator();

        switch (data) {
            case SymbolsEnum.FLOAT : {
                this.display.addDigit(SymbolsEnum.FLOAT);
            }
            case SymbolsEnum.EQUAL : {
                if (this.currentValue == null) return;

                this.doOperation(null);
                this.mustClear = true;
            }
        }
    }

    private function onButtonOperation(e:PriEvent):Void {
        e.stopBubble();

        var operation:OperationsEnum = e.data;
        if (this.mustClear) {
            this.mustClear = false;
        }

        this.doOperation(operation);
    }

    private function doOperation(futureOperation:OperationsEnum):Void {
        var displayValue:Float = this.display.getValue();
        var currentValue:Float = this.currentValue == null ? 0 : this.currentValue;
        var finalValue:Float = 0;

        switch (this.currentOperation) {
            case OperationsEnum.PLUS : {
                finalValue = currentValue + displayValue;
            }
            case OperationsEnum.MINUS : {
                finalValue = currentValue - displayValue;
            }
            case OperationsEnum.MULTIPLY : {
                finalValue = currentValue * displayValue;
            }
            case OperationsEnum.DIVIDE : {
                finalValue = currentValue / displayValue;
            }
            case null : {
                finalValue = displayValue;
            }
        }

        // let´s fix JS float number errors
        // http://floating-point-gui.de/
        var bigNumber:Float = Math.pow(10, FLOAT_PRECISION);
        finalValue = Math.floor(finalValue * bigNumber) / bigNumber;


        if (futureOperation == null) {
            this.display.setHistory('${currentValue} ${this.currentOperation} ${displayValue} ${SymbolsEnum.EQUAL}');
            this.display.setValue(finalValue);
        } else {
            this.display.setHistory('${finalValue} ${futureOperation}');
            this.display.setValue(0);
        }

        this.currentOperation = futureOperation;
        this.currentValue = finalValue;
    }

    private function clearCalculator():Void {
        this.mustClear = false;

        this.currentOperation = null;
        this.currentValue = null;

        this.display.setHistory("");
        this.display.setValue(0);
    }
}
