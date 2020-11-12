import { HttpClient } from '@angular/common/http';
import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { ServerErrorResponse } from 'src/app/@models/error';
import { Recipe } from 'src/app/@models/recipe';

@Component({
  selector: 'app-add-form',
  templateUrl: './form.component.html',
  styleUrls: ['./form.component.scss']
})
export class RecipeFormComponent implements OnInit {
  form: FormGroup;

  constructor(
    private http: HttpClient,
    private router: Router
  ) {
    this.form = new FormGroup({
      url: new FormControl('', [ Validators.required ]),
    });
  }

  ngOnInit(): void {
  }

  onSubmit(): void {
    var recipe = new Recipe();
    recipe.url = this.form.value.url;

    this.http.post<Recipe>('/api/recipes/', recipe).subscribe(
      (recipe: Recipe) => {
        this.router.navigate(['recipes']);
      },
      (e: any) => {
        if (e.status == 422 || e.status == 409) {
          let response: ServerErrorResponse = e.error;

          response.detail.forEach(error => {
            this.form.controls[error.loc[1]].setErrors({
              server: error.msg
            });
          });
        }
      }
    );
  }
}
