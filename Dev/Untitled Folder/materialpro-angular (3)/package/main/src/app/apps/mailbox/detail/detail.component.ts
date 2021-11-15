import { Component, OnInit } from '@angular/core';
import { getUser } from '../user-data';
import { mailGlobalVariable, mailService } from '../mail.service';
import { Router } from '@angular/router';
import { PerfectScrollbarConfigInterface } from 'ngx-perfect-scrollbar';

@Component({
    selector: 'app-maildetail',
    templateUrl: './detail.component.html',
    styleUrls: ['./detail.component.css']
})
export class DetailComponent {
    // tslint:disable-next-line: no-shadowed-variable
    constructor(public ms: mailGlobalVariable, public mailService: mailService, public router: Router) { }

    public config: PerfectScrollbarConfigInterface = {};


    labelClick(type: string): void {
        if (this.ms.selectedMail) {
            if (type === 'Personal') {
                if (this.ms.selectedMail.label.indexOf('Personal') === -1) {
                    this.ms.selectedMail.label.push('Personal');
                } else {
                    this.ms.selectedMail.label = this.ms.selectedMail.label.
                        filter(str => str !== 'Personal');
                }
            } else if (type === 'Work') {
                if (this.ms.selectedMail.label.indexOf('Work') === -1) {
                    this.ms.selectedMail.label.push('Work');
                } else {
                    this.ms.selectedMail.label = this.ms.selectedMail.label.
                        filter(str => str !== 'Work');
                }
            } else if (type === 'Payment') {
                if (this.ms.selectedMail.label.indexOf('Payment') === -1) {
                    this.ms.selectedMail.label.push('Payment');
                } else {
                    this.ms.selectedMail.label = this.ms.selectedMail.label.
                        filter(str => str !== 'Payment');
                }
            } else if (type === 'Invoice') {
                if (this.ms.selectedMail.label.indexOf('Invoice') === -1) {
                    this.ms.selectedMail.label.push('Invoice');
                } else {
                    this.ms.selectedMail.label = this.ms.selectedMail.label.
                        filter(str => str !== 'Invoice');
                }
            } else if (type === 'Account') {
                if (this.ms.selectedMail.label.indexOf('Account') === -1) {
                    this.ms.selectedMail.label.push('Account');
                } else {
                    this.ms.selectedMail.label = this.ms.selectedMail.label.
                        filter(str => str !== 'Account');
                }
            }
        }
    }

    ddlRemoveClick(st: string): void {
        if (this.ms.selectedMail) {
            if (st === 'Spam') {
                this.ms.selectedMail.mailbox = 'Spam';

                this.ms.spamList.push(this.ms.selectedMail);
                this.ms.selectedMail = null;
                this.resetCount();
            } else if (st === 'Trash') {
                this.ms.selectedMail.mailbox = 'Trash';
                this.ms.trashList.push(this.ms.selectedMail);
                this.ms.selectedMail = null;
                this.resetCount();
            } else if (st === 'Read') {
                if (this.ms.selectedMail.seen) {
                    this.ms.selectedMail.seen = false;
                    this.ms.global();
                } else if (!this.ms.selectedMail.seen) {
                    this.ms.selectedMail.seen = true;
                    this.ms.global();
                }
            }
        }

    }

    iconsClick(name: string): void {
        if (this.ms.selectedMail) {
            if (name === 'Star') {
                if (this.ms.selectedMail.filter.indexOf('Star') !== -1) {
                    this.ms.selectedMail.filter = this.ms.selectedMail.filter.
                        filter(fil => fil !== 'Star');
                } else {
                    this.ms.selectedMail.filter.push('Star');
                }
            }
            if (name === 'Important') {
                if (this.ms.selectedMail.filter.indexOf('Important') !== -1) {
                    this.ms.selectedMail.filter = this.ms.selectedMail.filter.
                        filter(fil => fil !== 'Important');
                } else {
                    this.ms.selectedMail.filter.push('Important');
                }

            }
        }
    }

    resetCount(): void {
        this.ms.inboxList = this.mailService.getInbox();
        this.ms.sentList = this.mailService.getSent();
        this.ms.draftList = this.mailService.getDraft();
        this.ms.spamList = this.mailService.getSpam();
        this.ms.trashList = this.mailService.getTrash();
        this.ms.mailList = this.ms.inboxList;
        this.ms.users = [];
        for (const mail of this.ms.mailList) {
            const User = getUser(mail.fromId);
            if (User !== null) {
                this.ms.users.push(User);
            }
        }
        this.ms.collectionSize = this.ms.inboxList.length;
        this.ms.selectedMail = null;
        this.ms.topLable = 'Inbox';
        this.ms.type = 'inbox';
        this.ms.global();
    }


    reply(): void {
        this.ms.replyShow = true;
    }

    sendButtonClick(): void {
        this.ms.replyShow = false;
    }

    removeClass(): void {
        this.ms.addClass = false;
    }

}


