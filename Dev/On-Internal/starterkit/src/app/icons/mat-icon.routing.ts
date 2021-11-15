import { Routes } from '@angular/router';

import { MatIconComponent } from './mat-icon.component';

export const IconsRoutes: Routes = [
  {
    path: '',
    children: [
      {
        path: 'icons',
        component: MatIconComponent,
		data: {
          title: 'Material Icons',
          urls: [
            { title: 'Dashboard', url: '/dashboard' },
            { title: 'Material Icons' }
          ]
        }
      }
    ]
  }
];
