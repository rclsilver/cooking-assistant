import { Component, Inject } from '@angular/core';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';

@Component({
  selector: 'app-success-dialog',
  templateUrl: './success-dialog.component.html',
  styleUrls: ['./success-dialog.component.scss']
})
export class SuccessDialogComponent {
  constructor(
    @Inject(MAT_DIALOG_DATA) public data: {
      message: string,
      title: string
    },
    private dialog: MatDialogRef<SuccessDialogComponent>
  ) { }

  close(): void {
    this.dialog.close();
  }
}
