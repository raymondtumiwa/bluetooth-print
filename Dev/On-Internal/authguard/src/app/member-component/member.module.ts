
import { NgModule } from '@angular/core';
import { RouterModule } from '@angular/router';
import { CommonModule } from '@angular/common';

import { DemoMaterialModule } from '../demo-material-module';
import { CdkTableModule } from '@angular/cdk/table';

import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { FlexLayoutModule } from '@angular/flex-layout';

import { MemberRoutes } from './member.routing';
import { MemberpertamaComponent } from './memberpertama/memberpertama.component';
import { MemberkeduaComponent } from './memberkedua/memberkedua.component'

@NgModule({
    imports: [
        CommonModule,
        RouterModule.forChild(MemberRoutes),
        DemoMaterialModule,
        FormsModule,
        ReactiveFormsModule,
        FlexLayoutModule,
        CdkTableModule
    ],
    providers: [
    ],
    declarations: [
       MemberpertamaComponent,
       MemberkeduaComponent
    ]
})
export class MemberComponentModule { }
