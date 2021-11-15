import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { MatDialog, MatDialogModule } from '@angular/material/dialog';
import { RouterTestingModule } from '@angular/router/testing';
import { ServiceinvoiceService } from '../serviceinvoice.service';

import { AddInvoiceComponent } from './add-invoice.component';

describe('AddInvoiceComponent', () => {
  let component: AddInvoiceComponent;
  let fixture: ComponentFixture<AddInvoiceComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ AddInvoiceComponent ],
      imports:[ReactiveFormsModule,RouterTestingModule,FormsModule ,MatDialogModule],
      providers:[ServiceinvoiceService,MatDialog]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(AddInvoiceComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  // it('should create', () => {
  //   expect(component).toBeTruthy();
  // });
});
