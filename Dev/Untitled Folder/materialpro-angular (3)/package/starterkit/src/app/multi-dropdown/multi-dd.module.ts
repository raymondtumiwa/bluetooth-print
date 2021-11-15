import { NgModule } from '@angular/core';
import { RouterModule } from '@angular/router';
import { CommonModule } from '@angular/common';
import { DemoMaterialModule } from '../demo-material-module';
import { FlexLayoutModule } from '@angular/flex-layout';
import { SecondLevelComponent } from './second-level.component';
import { ThirdLevelComponent } from './third-level/third-level.component';
import { MultiRoutes } from './multi-dd.routing';

@NgModule({
  imports: [
    CommonModule,
    DemoMaterialModule,
    FlexLayoutModule,
    RouterModule.forChild(MultiRoutes)
  ],
  declarations: [SecondLevelComponent, ThirdLevelComponent]
})
export class MultiModule {}
