import { Component, OnInit } from '@angular/core';
import { Note } from './note';
import { NoteService } from './note.service';

@Component({
    selector: 'app-notes',
    templateUrl: './notes.component.html',
    styleUrls: ['./notes.component.scss']
})
export class NotesComponent implements OnInit {

    sidePanelOpened = true;

    notes = this.noteService.getNotes();
    selectedNote: Note = Object.create(null);
    searchText = '';
    clrName = 'warning';
    colors = [{ colorName: 'info' }, { colorName: 'warning' }, { colorName: 'danger' }, { colorName: 'success' }];
    constructor(public noteService: NoteService) {
    }

    isOver(): boolean {
        return window.matchMedia(`(max-width: 960px)`).matches;
    }

    ngOnInit(): void {
        this.onLoad();
    }
    onLoad(): void {
        this.selectedNote = this.notes[0];
    }
    onSelect(note: Note): void {
        this.selectedNote = note;
        this.clrName = this.selectedNote.color;
    }
    onSelectColor(colorName: string): void {
        this.clrName = colorName;
        this.selectedNote.color = this.clrName;
    }
    removenote(note: Note): void {
        const index: number = this.notes.indexOf(note);
        if (index !== -1) {
            this.notes.splice(index, 1);
            this.selectedNote = this.notes[0];
        }
    }
    addNoteClick(): void {
        this.notes.push({
            color: this.clrName,
            title: 'this is New notes',
            datef: new Date()
        });
    }
}
