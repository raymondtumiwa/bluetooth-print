import { TestBed } from '@angular/core/testing';

import { ServiceinvoiceService } from './serviceinvoice.service';

describe('ServiceinvoiceService', () => {
  let service: ServiceinvoiceService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(ServiceinvoiceService);
  });

  // it('should be created', () => {
  //   expect(service).toBeTruthy();
  // });
});
