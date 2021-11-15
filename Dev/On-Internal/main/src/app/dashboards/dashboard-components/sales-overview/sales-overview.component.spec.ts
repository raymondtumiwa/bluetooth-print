import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { SalesOverviewComponent } from './sales-overview.component';

describe('SalesOverviewComponent', () => {
  let component: SalesOverviewComponent;
  let fixture: ComponentFixture<SalesOverviewComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ SalesOverviewComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(SalesOverviewComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  // it('should create', () => {
  //   expect(component).toBeTruthy();
  // });
});
