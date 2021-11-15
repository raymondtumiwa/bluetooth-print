import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { SalesPurchaseComponent } from './sales-purchase.component';

describe('SalesPurchaseComponent', () => {
  let component: SalesPurchaseComponent;
  let fixture: ComponentFixture<SalesPurchaseComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ SalesPurchaseComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(SalesPurchaseComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  // it('should create', () => {
  //   expect(component).toBeTruthy();
  // });
});
