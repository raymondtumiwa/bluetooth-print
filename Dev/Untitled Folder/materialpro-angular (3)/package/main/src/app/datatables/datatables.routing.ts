import { Routes } from '@angular/router';

import { DataTableComponent } from './data-table/data-table.component';
import { TableEditingComponent } from './table-editing/table-editing.component';
import { TableFilterComponent } from './table-filter/table-filter.component';
import { MaterialTableComponent } from './materialtable/materialtable.component';
export const DataTablesRoutes: Routes = [
  {
    path: '',
    children: [
      {
        path: 'basicdatatable',
        component: DataTableComponent,
        data: {
          title: 'Basic Datatable',
          urls: [
            { title: 'Dashboard', url: '/dashboard' },
            { title: 'Basic Datatable' }
          ]
        }
      },
      {
        path: 'editing',
        component: TableEditingComponent,
        data: {
          title: 'Editing Table',
          urls: [
            { title: 'Dashboard', url: '/dashboard' },
            { title: 'Editing Table' }
          ]
        }
      },
      {
        path: 'filter',
        component: TableFilterComponent,
        data: {
          title: 'Filter Table',
          urls: [
            { title: 'Dashboard', url: '/dashboard' },
            { title: 'Filter Table' }
          ]
        }
      },
      {
        path: 'materialtable',
        component: MaterialTableComponent,
        data: {
          title: 'Material Table',
          urls: [
            { title: 'Dashboard', url: '/dashboard' },
            { title: 'Material Table' }
          ]
        }
      }
    ]
  }
];
