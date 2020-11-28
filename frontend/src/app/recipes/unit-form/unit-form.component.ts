import { Component, Inject } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { MatDialog, MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { ApiService } from 'src/app/shared/api.service';
import { SuccessDialogComponent } from 'src/app/shared/success-dialog/success-dialog.component';
import { Unit } from '../types';

@Component({
  selector: 'app-unit-form',
  templateUrl: './unit-form.component.html',
  styleUrls: ['./unit-form.component.scss'],
})
export class UnitFormComponent {
  form: FormGroup;

  constructor(
    @Inject(MAT_DIALOG_DATA)
    public data: {
      unit: Unit | null;
    },
    private dialogRef: MatDialogRef<UnitFormComponent>,
    private formBuilder: FormBuilder,
    private api: ApiService,
    private dialog: MatDialog
  ) {
    this.form = this.formBuilder.group({
      label: [
        this.data.unit ? this.data.unit.label : null,
        [Validators.required]
      ],
      label_plural: [
        this.data.unit ? this.data.unit.label_plural : null
      ]
    });
  }

  cancel(): void {
    this.dialogRef.close(false);
  }

  submit(): void {
    let promise: Promise<Unit> = this.data.unit ?
      this.api.updateUnit(this.data.unit, this.form.value) :
      this.api.createUnit(this.form.value);

    promise
      .then((unit: Unit) => {
        this.dialog
          .open(SuccessDialogComponent, {
            data: {
              title: this.data.unit ? 'Unit update' : 'Unit creation',
              message: this.data.unit
                ? 'Recipe has been updated successfully'
                : 'Recipe has been created successfully',
            },
          })
          .afterClosed()
          .subscribe(() => this.dialogRef.close(true));
      })
      .catch(this.api.handleFormError(this.form));
  }
}
