import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { VisitorComponent } from './visitor.component';

describe('VisitorComponent', () => {
  let component: VisitorComponent;
  let fixture: ComponentFixture<VisitorComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ VisitorComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(VisitorComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  // it('should create', () => {
  //   expect(component).toBeTruthy();
  // });
});
