import { Routes } from '@angular/router';

import { TestingComponent } from './testing.component';

export const TestingRoutes: Routes = [
  {
    path: '',
    component: TestingComponent,
	data: {
      title: 'Testing Page',
      urls: [
        { title: 'Dashboard', url: '/dashboard' },
        { title: 'Testing Page' }
      ]
    }
  }
];
