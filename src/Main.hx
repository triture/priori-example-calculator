package ;

import view.Calculator;
import priori.style.font.PriFontStyle;
import priori.app.PriApp;

class Main extends PriApp {

    private var calculator:Calculator;

    public function new() {

        // setting my defalt font - do this before "super()"
        PriFontStyle.DEFAULT_FAMILY = "'Muli', sans-serif";

        super();
    }

    override private function setup():Void {

        this.bgColor = 0x333333;

        this.calculator = new Calculator();
        this.addChild(this.calculator);
    }

    override private function paint():Void {

        var space:Int = 20;

        var calculatorWidth:Float = this.width * 0.3;
        if (calculatorWidth < 350) calculatorWidth = this.width *0.5;
        if (calculatorWidth < 350) calculatorWidth = this.width *0.7;
        if (calculatorWidth < 350) calculatorWidth = this.width - space*2;

        var calculatorHeight:Float = this.height - space*2;

        this.calculator.width = calculatorWidth;
        this.calculator.height = calculatorHeight;

        this.calculator.centerX = this.width/2;
        this.calculator.centerY = this.height/2;
    }

}
