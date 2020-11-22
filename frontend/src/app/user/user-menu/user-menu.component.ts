import { Component } from '@angular/core';
import { Observable } from 'rxjs';
import { AuthService } from 'src/app/core/auth.service';

@Component({
  selector: 'app-user-menu',
  templateUrl: './user-menu.component.html',
  styleUrls: ['./user-menu.component.scss']
})
export class UserMenuComponent {
  isAuthenticated: Observable<boolean>;

  constructor(private auth: AuthService) {
    this.isAuthenticated = auth.isAuthenticated$;
  }

  login() {
    this.auth.login();
  }

  logout() {
    this.auth.logout();
  }

  get identity(): any {
    return this.auth.identity;
  }
}
