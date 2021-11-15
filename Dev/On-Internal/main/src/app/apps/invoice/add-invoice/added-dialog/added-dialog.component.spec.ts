import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { AddedDialogComponent } from './added-dialog.component';

describe('AddedDialogComponent', () => {
  let component: AddedDialogComponent;
  let fixture: ComponentFixture<AddedDialogComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ AddedDialogComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(AddedDialogComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  // it('should create', () => {
  //   expect(component).toBeTruthy();
  // });
});
