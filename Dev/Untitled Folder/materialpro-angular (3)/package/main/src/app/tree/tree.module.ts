
import { NgModule } from '@angular/core';
import { RouterModule } from '@angular/router';
import { CommonModule } from '@angular/common';
import { DemoMaterialModule } from '../demo-material-module';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { MatTreeModule } from '@angular/material/tree';
import { FlexLayoutModule } from '@angular/flex-layout';
import { TreeRoutes } from './tree.routing';
import {CdkTreeModule} from '@angular/cdk/tree';


import { DynamictreeComponent } from './dynamic-tree/dynamic-tree.component';
import { FlattreeComponent } from './flat-tree/flat-tree.component';
import { LoadtreeComponent } from './load-tree/load-tree.component';
import { NestedtreeComponent } from './nested-tree/nested-tree.component';

@NgModule({
    imports: [
        CommonModule,
        RouterModule.forChild(TreeRoutes),
        DemoMaterialModule,
        FlexLayoutModule,
        FormsModule,
        MatTreeModule,
        CdkTreeModule,
        ReactiveFormsModule
    ],
    declarations: [
        DynamictreeComponent,
        FlattreeComponent,
        LoadtreeComponent,
        NestedtreeComponent
    ]
})
export class TreeModule { }
