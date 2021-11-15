import { Routes } from '@angular/router';
import { WidgetsComponent } from './widgets.component';

export const WidgetsRoutes: Routes = [
  {
    path: '',
    component: WidgetsComponent,
    data: {
      title: 'Widgets',
      urls: [
        { title: 'Dashboard', url: '/dashboard' },
        { title: 'Widgets' }
      ]
    }
  }
];
