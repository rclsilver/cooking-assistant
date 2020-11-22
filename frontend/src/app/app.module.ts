import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { RecipeCardComponent } from './recipe/card/card.component';
import { RecipeListComponent } from './recipe/list/list.component';
import { AboutComponent } from './about/about.component';
import { RecipeScoreComponent } from './recipe/score/score.component';
import { PageNotFoundComponent } from './errors/page-not-found/page-not-found.component';
import { RecipeFormComponent } from './recipe/form/form.component';
import { ReactiveFormsModule } from '@angular/forms';
import { UserMenuComponent } from './user/user-menu/user-menu.component';
import { CoreModule } from './core/core.module';

@NgModule({
  declarations: [
    AboutComponent,
    AppComponent,
    PageNotFoundComponent,
    RecipeFormComponent,
    RecipeCardComponent,
    RecipeListComponent,
    RecipeScoreComponent,
    UserMenuComponent
  ],
  imports: [
    BrowserModule,
    CoreModule.forRoot(),
    AppRoutingModule,
    ReactiveFormsModule
  ],
  bootstrap: [AppComponent],
})
export class AppModule {}
