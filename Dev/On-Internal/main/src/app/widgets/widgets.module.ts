import { NgModule } from '@angular/core';
import { RouterModule } from '@angular/router';
import { CommonModule } from '@angular/common';
import { DemoMaterialModule } from '../demo-material-module';
import { FlexLayoutModule } from '@angular/flex-layout';
import { WidgetsComponent } from './widgets.component';
import { WidgetsRoutes } from './widgets.routing';

@NgModule({
  imports: [
    CommonModule,
    DemoMaterialModule,
    FlexLayoutModule,
    RouterModule.forChild(WidgetsRoutes)
  ],
  declarations: [WidgetsComponent]
})
export class WidgetsModule {}
