import { Routes } from '@angular/router';

import { MatIconComponent } from './material-icons/mat-icon.component';
import { TimelineComponent } from './timeline/timeline.component';
import { InvoiceComponent } from './invoice/invoice.component';
import { PricingComponent } from './pricing/pricing.component';
import { HelperComponent } from './helper-classes/helper.component';

export const PagesRoutes: Routes = [
  {
    path: '',
    children: [
      {
        path: 'icons/material',
        component: MatIconComponent,
        data: {
          title: 'Material Icons',
          urls: [
            { title: 'Dashboard', url: '/dashboard' },
            { title: 'Material Icons' }
          ]
        }
      },
      {
        path: 'timeline',
        component: TimelineComponent,
        data: {
          title: 'Timeline',
          urls: [
            { title: 'Dashboard', url: '/dashboard' },
            { title: 'Timeline' }
          ]
        }
      },
      {
        path: 'invoice',
        component: InvoiceComponent,
        data: {
          title: 'Invoice',
          urls: [
            { title: 'Dashboard', url: '/dashboard' },
            { title: 'Invoice' }
          ]
        }
      },
      {
        path: 'pricing',
        component: PricingComponent,
        data: {
          title: 'Pricing',
          urls: [
            { title: 'Dashboard', url: '/dashboard' },
            { title: 'Pricing' }
          ]
        }
      },
      {
        path: 'helper',
        component: HelperComponent,
        data: {
          title: 'Helper',
          urls: [
            { title: 'Dashboard', url: '/dashboard' },
            { title: 'Helper' }
          ]
        }
      }
    ]
  }
];
