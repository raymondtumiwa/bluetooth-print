import { Component, OnInit } from '@angular/core';
import { coerceNumberProperty } from '@angular/cdk/coercion';

@Component({
  selector: 'app-slider',
  templateUrl: './slider.component.html',
  styleUrls: ['./slider.component.scss']
})
export class SliderComponent {
  demo = 0;
  val = 50;
  min = 0;
  max = 100;

  // 2
  autoTicks = false;
  disabled = false;
  invert = false;
  showTicks = false;
  step = 1;
  thumbLabel = false;
  value = 0;
  vertical = false;
  // tslint:disable-next-line - Disables all
  private _tickInterval = 1;
  get tickInterval(): number | 'auto' {
    return this.showTicks ? (this.autoTicks ? 'auto' : this._tickInterval) : 0;
  }
  set tickInterval(value) {
    this._tickInterval = coerceNumberProperty(value);
  }

  constructor() { }
}
