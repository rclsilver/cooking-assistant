import { HttpErrorResponse } from '@angular/common/http';
import { Component, Inject } from '@angular/core';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';

@Component({
  selector: 'app-server-error-dialog',
  templateUrl: './server-error-dialog.component.html',
  styleUrls: ['./server-error-dialog.component.scss'],
})
export class ServerErrorDialogComponent {
  constructor(
    @Inject(MAT_DIALOG_DATA)
    public data: {
      title: string;
      message: string | null;
      error: HttpErrorResponse;
    },
    private dialog: MatDialogRef<ServerErrorDialogComponent>
  ) {}

  close(): void {
    this.dialog.close();
  }
}
