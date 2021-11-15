import { Routes } from '@angular/router';

import { BasicTableComponent } from './basic-table/basic-table.component';
import { FilterableComponent } from './filterable/filterable.component';
import { PaginationComponent } from './pagination/pagination.component';
import { SortableComponent } from './sortable/sortable.component';
import { MixComponent } from './mix/mix.component';
import { DynamicTableComponent } from './dynamic-table/dynamic-table.component';
import { ExpandTableComponent } from './expand-table/expand-table.component';
import { FooterrowTableComponent } from './footerrow-table/footerrow-table.component';
import { MultipleheaderfooterTableComponent } from './multiple-header-footer/multiple-header-footer.component';
import { HttptableComponent } from './http-table/http-table.component';
import { RowcontextTableComponent } from './row-context-table/row-context-table.component';
import { SelectionTableComponent } from './selection-table/selection-table.component';
import { StickycolumnTableComponent } from './sticky-column-table/sticky-column-table.component';
import { StickyheaderfooterTableComponent } from './sticky-header-footer-table/sticky-header-footer-table.component';

export const TablesRoutes: Routes = [
    {
        path: '',
        children: [
            {
                path: 'basictable',
                component: BasicTableComponent,
                data: {
                    title: 'Basic Table',
                    urls: [
                        { title: 'Dashboard', url: '/dashboard' },
                        { title: 'Basic Table' }
                    ]
                }
            },
            {
                path: 'filterable',
                component: FilterableComponent,
                data: {
                    title: 'Filter Table',
                    urls: [
                        { title: 'Dashboard', url: '/dashboard' },
                        { title: 'Filter Table' }
                    ]
                }
            },
            {
                path: 'pagination',
                component: PaginationComponent,
                data: {
                    title: 'Pagination Table',
                    urls: [
                        { title: 'Dashboard', url: '/dashboard' },
                        { title: 'Pagination Table' }
                    ]
                }
            },
            {
                path: 'sortable',
                component: SortableComponent,
                data: {
                    title: 'Sortable',
                    urls: [
                        { title: 'Dashboard', url: '/dashboard' },
                        { title: 'Sortable' }
                    ]
                }
            },
            {
                path: 'mix',
                component: MixComponent,
                data: {
                    title: 'Mix Table',
                    urls: [
                        { title: 'Dashboard', url: '/dashboard' },
                        { title: 'Mix Table' }
                    ]
                }
            },
            {
                path: 'dynamic-table',
                component: DynamicTableComponent,
                data: {
                    title: 'Dynamic Table',
                    urls: [
                        { title: 'Dashboard', url: '/dashboard' },
                        { title: 'Dynamic Table' }
                    ]
                }
            },
            {
                path: 'expand-table',
                component: ExpandTableComponent,
                data: {
                    title: 'Expand Table',
                    urls: [
                        { title: 'Dashboard', url: '/dashboard' },
                        { title: 'Expand Table' }
                    ]
                }
            },
            {
                path: 'footerrow-table',
                component: FooterrowTableComponent,
                data: {
                    title: 'Footer row Table',
                    urls: [
                        { title: 'Dashboard', url: '/dashboard' },
                        { title: 'Footer row Table' }
                    ]
                }
            },
            {
                path: 'multiple-header-footer',
                component: MultipleheaderfooterTableComponent,
                data: {
                    title: 'Multiple Header Footer',
                    urls: [
                        { title: 'Dashboard', url: '/dashboard' },
                        { title: 'Multiple Header Footer' }
                    ]
                }
            },
            {
                path: 'http-table',
                component: HttptableComponent,
                data: {
                    title: 'HTTP Table',
                    urls: [
                        { title: 'Dashboard', url: '/dashboard' },
                        { title: 'HTTP Table' }
                    ]
                }
            },
            {
                path: 'row-context-table',
                component: RowcontextTableComponent,
                data: {
                    title: 'Row Context Table',
                    urls: [
                        { title: 'Dashboard', url: '/dashboard' },
                        { title: 'Row Context Table' }
                    ]
                }
            },
            {
                path: 'selection-table',
                component: SelectionTableComponent,
                data: {
                    title: 'Selection Table',
                    urls: [
                        { title: 'Dashboard', url: '/dashboard' },
                        { title: 'Selection Table' }
                    ]
                }
            },
            {
                path: 'sticky-column-table',
                component: StickycolumnTableComponent,
                data: {
                    title: 'Sticky Column Table',
                    urls: [
                        { title: 'Dashboard', url: '/dashboard' },
                        { title: 'Sticky Column Table' }
                    ]
                }
            },
            {
                path: 'sticky-footer-table',
                component: StickyheaderfooterTableComponent,
                data: {
                    title: 'Sticky Header Footer Table',
                    urls: [
                        { title: 'Dashboard', url: '/dashboard' },
                        { title: 'Sticky Header Footer Table' }
                    ]
                }
            }
        ]
    }
];
