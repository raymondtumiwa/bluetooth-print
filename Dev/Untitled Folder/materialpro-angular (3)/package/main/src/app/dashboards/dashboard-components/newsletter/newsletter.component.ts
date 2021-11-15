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

// tslint:disable-next-line: class-name
export interface newsletterchartOptions {
    series: ApexAxisChartSeries;
    chart: ApexChart;
    xaxis: ApexXAxis;
    stroke: any;
    tooltip: ApexTooltip;
    dataLabels: ApexDataLabels;
    legend: ApexLegend;
    colors: string[];
    markers: any;
    grid: ApexGrid;
}

@Component({
    selector: 'app-newsletter',
    templateUrl: './newsletter.component.html',
    styleUrls: ['./newsletter.component.scss']
})
export class NewsletterComponent implements OnInit {

    @ViewChild('newsletter-chart') chart3: ChartComponent = Object.create(null);
    public newsletterchartOptions: Partial<newsletterchartOptions>;

    constructor() {
        this.newsletterchartOptions = {
            series: [
                {
                    name: 'Clicked',
                    data: [0, 5000, 15000, 8000, 15000, 9000, 30000, 0]
                },
                {
                    name: 'Sent',
                    data: [0, 3000, 5000, 2000, 8000, 1000, 5000, 0]
                }
            ],
            chart: {
                height: 290,
                fontFamily: 'Poppins,sans-serif',
                type: 'area'
            },
            dataLabels: {
                enabled: false
            },
            markers: {
                size: 3,
            },
            stroke: {
                curve: 'smooth',
                width: '2'
            },
            colors: ['#26c6da', '#1e88e5'],
            legend: {
                show: false,
            },
            grid: {
                borderColor: 'rgba(0,0,0,.2)',
                strokeDashArray: 3,
                yaxis: {
                    lines: {
                        show: true
                    }
                },
                xaxis: {
                    lines: {
                        show: true
                    }
                },
            },
            xaxis: {
                type: 'category',
                categories: [
                    '1',
                    '2',
                    '3',
                    '4',
                    '5',
                    '6',
                    '7',
                    '8'
                ]
            },
            tooltip: {
                theme: 'light',
                x: {
                    format: 'dd/MM/yy HH:mm'
                }
            }
        };
    }

    ngOnInit(): void {
    }

}
