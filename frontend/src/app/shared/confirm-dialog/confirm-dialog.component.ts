import { Component, Inject } from '@angular/core';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';

@Component({
  selector: 'app-confirm-dialog',
  templateUrl: './confirm-dialog.component.html',
  styleUrls: ['./confirm-dialog.component.scss'],
})
export class ConfirmDialogComponent {
  constructor(
    @Inject(MAT_DIALOG_DATA)
    public data: {
      message: string;
      title: string;
      confirmText: string | null;
      cancelText: string | null;
    },
    private dialog: MatDialogRef<ConfirmDialogComponent>
  ) {}

  cancel(): void {
    this.dialog.close(false);
  }

  confirm(): void {
    this.dialog.close(true);
  }
}
