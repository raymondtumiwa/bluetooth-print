import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { mailGlobalVariable, mailService } from '../mail.service';
import { RouterTestingModule } from '@angular/router/testing';
import { DetailComponent } from './detail.component';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { MatDialogModule } from '@angular/material/dialog';

describe('DetailComponent', () => {
  let component: DetailComponent;
  let fixture: ComponentFixture<DetailComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [DetailComponent],
      imports: [ReactiveFormsModule, FormsModule, RouterTestingModule, MatDialogModule],
      providers: [mailGlobalVariable, mailService]
    })
      .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(DetailComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  // it('should create', () => {
  //   expect(component).toBeTruthy();
  // });
});
