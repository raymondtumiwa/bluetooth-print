import { Injectable } from '@angular/core';
import { Note } from './note';
import { notes } from './notes-data';


@Injectable()
export class NoteService {


    public notes: Note[] = notes;

    public getNotes(): Note[] {
        return this.notes;
    }
}
