import { Routes } from '@angular/router';

import { ChartjsComponent } from './chart-js/chartjs.component';
import { ChartistjsComponent } from './chartist-js/chartistjs.component';
import { NgxchartComponent } from './ngx-charts/ngx-chart.component';

export const ChartsRoutes: Routes = [
  {
    path: '',
    children: [
      {
        path: 'chartjs',
        component: ChartjsComponent,
        data: {
          title: 'ChartJs',
          urls: [
            { title: 'Dashboard', url: '/dashboard' },
            { title: 'ChartJs' }
          ]
        }
      },
      {
        path: 'chartistjs',
        component: ChartistjsComponent,
        data: {
          title: 'Chartist Charts',
          urls: [
            { title: 'Dashboard', url: '/dashboard' },
            { title: 'Chartist Charts' }
          ]
        }
      },
      {
        path: 'ngxchart',
        component: NgxchartComponent,
        data: {
          title: 'Ngx Charts',
          urls: [
            { title: 'Dashboard', url: '/dashboard' },
            { title: 'Ngx Charts' }
          ]
        }
      }
    ]
  }
];
