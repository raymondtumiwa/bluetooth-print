import { Component, AfterViewInit, ViewChild } from '@angular/core';
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

// tslint:disable-next-line - Disables all
export interface ticketstatus {
    series: ApexNonAxisChartSeries;
    chart: ApexChart;
    responsive: ApexResponsive[];
    labels: any;
    tooltip: ApexTooltip;
    legend: ApexLegend;
    colors: string[];
    stroke: any;
    dataLabels: ApexDataLabels;
    plotOptions: ApexPlotOptions;
}


@Component({
    templateUrl: './ticketdetails.component.html'
})
export class TicketdetailsComponent {
    @ViewChild('ticket-chart') chart2: ChartComponent = Object.create(null);
    public ticketstatus: Partial<ticketstatus>;
    constructor() {
        this.ticketstatus = {
            series: [45, 15, 27, 18],
            chart: {
                type: 'donut',
                height: 200
            },
            plotOptions: {
                pie: {
                    donut: {
                        size: '80px'
                    }
                }
            },
            tooltip: {
                fillSeriesColor: false,
            },
            dataLabels: {
                enabled: false,
            },
            stroke: {
                width: 0
            },
            legend: {
                show: false,
            },
            labels: ['Open', 'Closed', 'Pending', 'Other'],
            colors: ['#1e88e5', '#26c6da', '#745af2', '#eceff1'],
            responsive: [
                {
                    breakpoint: 480,
                    options: {
                        chart: {
                            width: 200
                        }
                    }
                }
            ]
        };
    }
}
