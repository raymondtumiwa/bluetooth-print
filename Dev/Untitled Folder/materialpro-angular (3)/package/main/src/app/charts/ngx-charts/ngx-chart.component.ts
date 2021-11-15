import { Component } from '@angular/core';
import * as shape from 'd3-shape';
import { single, multi, generateData } from './chartData';

@Component({
  selector: 'app-ngxchart',
  templateUrl: './ngx-chart.component.html',
  styleUrls: ['./ngx-chart.component.scss']
})
export class NgxchartComponent {
  single: any[] = [];
  multi: any[] = [];
  dateData: any[];
  dateDataWithRange: any[];
  range = false;
  // options
  showXAxis = true;
  showYAxis = true;
  gradient = false;
  showLegend = false;
  showXAxisLabel = true;
  tooltipDisabled = false;
  xAxisLabel = 'Country';
  showYAxisLabel = true;
  yAxisLabel = 'GDP Per Capita';
  showGridLines = true;
  innerPadding = 0;
  autoScale = true;
  timeline = false;
  barPadding = 8;
  groupPadding = 0;
  roundDomains = false;
  maxRadius = 10;
  minRadius = 3;
  view = '';
  showLabels = true;
  explodeSlices = false;
  doughnut = false;
  arcWidth = 0.25;
  rangeFillOpacity = 0.15;

  colorScheme = {
    domain: ['#4fc3f7', '#fb8c00', '#7460ee', '#f62d51', '#20c997', '#2962FF']
  };

  schemeType = 'ordinal';

  constructor() {
    Object.assign(this, { single, multi });
    this.dateData = generateData(6, false);
    this.dateDataWithRange = generateData(2, true);
  }

  get dateDataWithOrWithoutRange(): any {
    if (this.range) {
      return this.dateDataWithRange;
    } else {
      return this.dateData;
    }
  }
  // line interpolation
  curve = shape.curveLinear;
  select(data: string): void {
    console.log('Item clicked', data);
  }

  onLegendLabelClick(entry: string): void {
    console.log('Legend clicked', entry);
  }
}
