import { ComponentFixture, TestBed } from '@angular/core/testing';

import { OkTaskComponent } from './ok-task.component';

describe('OkTaskComponent', () => {
  let component: OkTaskComponent;
  let fixture: ComponentFixture<OkTaskComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ OkTaskComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(OkTaskComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  // it('should create', () => {
  //   expect(component).toBeTruthy();
  // });
});
