import { Injectable } from '@angular/core';

import { Message } from './message';
import { MESSAGES } from './mock-messages';

@Injectable()
export class MailService {
  getMessages(): Promise<Message[]> {
    return Promise.resolve(MESSAGES);
  }
}
