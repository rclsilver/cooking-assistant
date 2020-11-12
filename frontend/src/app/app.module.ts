import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { HttpClientModule } from '@angular/common/http';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { HashLocationStrategy, LocationStrategy } from '@angular/common';
import { RecipeCardComponent } from './recipe/card/card.component';
import { RecipeListComponent } from './recipe/list/list.component';
import { AboutComponent } from './about/about.component';
import { RecipeScoreComponent } from './recipe/score/score.component';
import { PageNotFoundComponent } from './errors/page-not-found/page-not-found.component';
import { RecipeFormComponent } from './recipe/form/form.component';
import { ReactiveFormsModule } from '@angular/forms';

@NgModule({
  declarations: [
    AboutComponent,
    AppComponent,
    PageNotFoundComponent,
    RecipeFormComponent,
    RecipeCardComponent,
    RecipeListComponent,
    RecipeScoreComponent,
  ],
  imports: [BrowserModule, AppRoutingModule, ReactiveFormsModule, HttpClientModule],
  providers: [
    {
      provide: LocationStrategy,
      useClass: HashLocationStrategy,
    },
  ],
  bootstrap: [AppComponent],
})
export class AppModule {}
