import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { MailboxComponent } from './mailbox.component';

describe('MailboxComponent', () => {
  let component: MailboxComponent;
  let fixture: ComponentFixture<MailboxComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ MailboxComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(MailboxComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  // it('should create', () => {
  //   expect(component).toBeTruthy();
  // });
});
