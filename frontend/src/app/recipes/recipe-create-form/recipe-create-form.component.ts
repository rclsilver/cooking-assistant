import { Location } from '@angular/common';
import { Component } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { MatDialog } from '@angular/material/dialog';
import { ApiService } from 'src/app/shared/api.service';
import { SuccessDialogComponent } from 'src/app/shared/success-dialog/success-dialog.component';
import { Recipe } from '../types';

@Component({
  templateUrl: './recipe-create-form.component.html',
  styleUrls: ['./recipe-create-form.component.scss'],
})
export class RecipeCreateFormComponent {
  form: FormGroup;

  constructor(
    private formBuilder: FormBuilder,
    private api: ApiService,
    private dialog: MatDialog,
    private location: Location
  ) {
    let urlPattern: RegExp = /(^|\s)((https?:\/\/)?[\w-]+(\.[\w-]+)+\.?(:\d+)?(\/\S*)?)/gi;

    this.form = this.formBuilder.group({
      title: [null, [Validators.required]],
      image_url: [null, [Validators.required, Validators.pattern(urlPattern)]],
    });
  }

  cancel(): void {
    this.location.back();
  }

  submit(): void {
    this.api
      .createRecipe(this.form.value)
      .then((recipe: Recipe) => {
        this.dialog
          .open(SuccessDialogComponent, {
            data: {
              title: 'Recipe creation',
              message: 'Recipe has been created successfully',
            },
          })
          .afterClosed()
          .subscribe(() => this.location.back());
      })
      .catch(this.api.handleFormError(this.form));
  }
}
