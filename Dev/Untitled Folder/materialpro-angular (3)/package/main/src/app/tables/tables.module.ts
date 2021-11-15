
import { NgModule } from '@angular/core';
import { RouterModule } from '@angular/router';
import { CommonModule } from '@angular/common';
import { DemoMaterialModule } from '../demo-material-module';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { FlexLayoutModule } from '@angular/flex-layout';
import { TablesRoutes } from './tables.routing';


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

@NgModule({
    imports: [
        CommonModule,
        RouterModule.forChild(TablesRoutes),
        DemoMaterialModule,
        FlexLayoutModule,
        FormsModule,
        ReactiveFormsModule
    ],
    declarations: [
        BasicTableComponent,
        FilterableComponent,
        PaginationComponent,
        SortableComponent,
        MixComponent,
        DynamicTableComponent,
        ExpandTableComponent,
        FooterrowTableComponent,
        MultipleheaderfooterTableComponent,
        HttptableComponent,
        RowcontextTableComponent,
        SelectionTableComponent,
        StickycolumnTableComponent,
        StickyheaderfooterTableComponent
    ]
})
export class TablesModule { }
