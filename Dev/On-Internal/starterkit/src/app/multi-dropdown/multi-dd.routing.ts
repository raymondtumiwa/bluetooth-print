import { Routes } from '@angular/router';

import { SecondLevelComponent } from './second-level.component';
import { ThirdLevelComponent } from './third-level/third-level.component';

export const MultiRoutes: Routes = [
  {
    path: 'second-level',
    component: SecondLevelComponent
  },
  {
    path: 'third-level/third-level',
    component: ThirdLevelComponent
  }
];
