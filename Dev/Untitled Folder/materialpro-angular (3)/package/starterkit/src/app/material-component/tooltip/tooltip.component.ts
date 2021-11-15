import { Component, ViewEncapsulation } from '@angular/core';
import { MAT_TOOLTIP_DEFAULT_OPTIONS, MatTooltipDefaultOptions, TooltipPosition } from '@angular/material/tooltip';
import { FormControl } from '@angular/forms';

/** Custom options the configure the tooltip's default show/hide delays. */
export const myCustomTooltipDefaults: MatTooltipDefaultOptions = {
    showDelay: 1000,
    hideDelay: 1000,
    touchendHideDelay: 1000,
};


@Component({
    selector: 'app-tooltip',
    templateUrl: './tooltip.component.html',
    styleUrls: ['./tooltip.component.scss'],
    encapsulation: ViewEncapsulation.None,
    providers: [
        { provide: MAT_TOOLTIP_DEFAULT_OPTIONS, useValue: myCustomTooltipDefaults }
    ],
})
export class TooltipComponent {
    positionOptions: TooltipPosition[] = ['after', 'before', 'above', 'below', 'left', 'right'];
    position = new FormControl(this.positionOptions[0]);

    showDelay = new FormControl(1000);
    hideDelay = new FormControl(2000);

    disabled = new FormControl(false);

    message = new FormControl('Info about the action');


    position1 = new FormControl(this.positionOptions[0]);
}
