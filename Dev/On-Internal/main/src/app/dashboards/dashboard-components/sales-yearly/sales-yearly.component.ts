import { Component, OnInit, ViewChild } from '@angular/core';
import {
  ApexAxisChartSeries,
  ApexChart,
  ChartComponent,
  ApexDataLabels,
  ApexPlotOptions,
  ApexYAxis,
  ApexLegend,
  ApexStroke,
  ApexXAxis,
  ApexFill,
  ApexTooltip,
  ApexGrid,
  ApexNonAxisChartSeries,
  ApexResponsive
} from 'ng-apexcharts';


export interface ChartOptions {
  series: ApexAxisChartSeries;
  chart: ApexChart;
  dataLabels: ApexDataLabels;
  plotOptions: ApexPlotOptions;
  yaxis: ApexYAxis;
  xaxis: ApexXAxis;
  fill: ApexFill;
  tooltip: ApexTooltip;
  stroke: ApexStroke;
  legend: ApexLegend;
  grid: ApexGrid;
}


@Component({
  selector: 'app-sales-yearly',
  templateUrl: './sales-yearly.component.html',
  styleUrls: ['./sales-yearly.component.scss']
})
export class SalesYearlyComponent implements OnInit {
  @ViewChild('chart') chart: ChartComponent = Object.create(null);
  public chartOptions: Partial<ChartOptions>;
  constructor() {
    this.chartOptions = {
      series: [
        {
          name: 'Ample',
          data: [9, 4, 11, 7, 10, 12]
        },
        {
          name: 'Pixel',
          data: [3, 2, 9, 5, 8, 10]
        }
      ],
      chart: {
        type: 'bar',
        fontFamily: 'Poppins,sans-serif',
        height: 320
      },
      grid: {
        borderColor: 'rgba(0,0,0,.2)',
        strokeDashArray: 3,
      },
      plotOptions: {
        bar: {
          horizontal: false,
          columnWidth: '40%',
          endingShape: 'flat'
        },

      },
      dataLabels: {
        enabled: false
      },
      stroke: {
        show: true,
        width: 2,
        colors: ['transparent']
      },
      xaxis: {
        categories: [
          'Feb',
          'Mar',
          'Apr',
          'May',
          'Jun',
          'Jul',
          'Aug',
          'Sep',
          'Oct'
        ]
      },

      legend: {
        show: false,
      },
      fill: {
        colors: ['#26c6da', '#1e88e5'],
        opacity: 1
      },
      tooltip: {
        theme: 'light',
        fillSeriesColor: false,
        marker: {
          show: true,
          fillColors: ['#26c6da', '#1e88e5']
        }
      },
    };
  }

  ngOnInit(): void {
  }

}
