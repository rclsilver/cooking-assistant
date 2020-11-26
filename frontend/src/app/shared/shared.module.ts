import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { HttpClientModule } from '@angular/common/http';
import { MatButtonModule } from '@angular/material/button';
import { MatDialogModule } from '@angular/material/dialog';
import { SuccessDialogComponent } from './success-dialog/success-dialog.component';
import { ConfirmDialogComponent } from './confirm-dialog/confirm-dialog.component';
import { ServerErrorDialogComponent } from './server-error-dialog/server-error-dialog.component';

@NgModule({
  declarations: [SuccessDialogComponent, ConfirmDialogComponent, ServerErrorDialogComponent],
  imports: [
    CommonModule,
    HttpClientModule,
    MatButtonModule,
    MatDialogModule
  ]
})
export class SharedModule { }
