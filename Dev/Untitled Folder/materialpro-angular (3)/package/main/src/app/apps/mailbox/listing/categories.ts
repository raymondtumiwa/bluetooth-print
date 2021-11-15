export interface Category {
    id: number;
    name: string;
    icon: string;
    count: number;
    color?: string;
    active: boolean;
}

export const mailbox = [
    {
        id: 1,
        name: 'Inbox',
        icon: 'mail_outline',
        count: 0,
        active: true
    },
    {
        id: 2,
        name: 'Sent',
        icon: 'send',
        count: 0,
        active: false
    },
    {
        id: 3,
        name: 'Draft',
        icon: 'drafts',
        count: 0,
        active: false
    },
    {
        id: 4,
        name: 'Spam',
        icon: 'error_outline',
        count: 0,
        active: false
    },
    {
        id: 5,
        name: 'Trash',
        icon: 'delete',
        count: 0,
        active: false
    }


];

export const filter = [
    {
        id: 501,
        name: 'Star',
        icon: 'star_outline',
        count: 0,
        active: false

    },
    {
        id: 502,
        name: 'Important',
        icon: 'label_important',
        count: 0,
        active: false
    }
];

export const label: Category[] = [
    {
        id: 701,
        name: 'Personal',
        icon: 'label',
        count: 0,
        color: '#1e88e5',
        active: false
    },
    {
        id: 702,
        name: 'Work',
        icon: 'label',
        count: 0,
        color: '#26c6da',
        active: false
    },
    {
        id: 703,
        name: 'Payments',
        icon: 'label',
        count: 0,
        color: '#fc4b6c',
        active: false
    },
    {
        id: 704,
        name: 'Invoice',
        icon: 'label',
        count: 0,
        color: '#7460ee',
        active: false
    },
    {
        id: 705,
        name: 'Accounts',
        icon: 'label',
        count: 0,
        color: '#ffb22b',
        active: false
    },
];
