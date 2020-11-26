import { ModuleWithProviders, NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { AuthConfig, OAuthModuleConfig, OAuthStorage } from 'angular-oauth2-oidc';
import { environment } from 'src/environments/environment';
import { HttpClientModule } from '@angular/common/http';
import { OAuthModule } from 'angular-oauth2-oidc';
import { AuthService } from './auth.service';
import { RequireUserGuard } from './require-user.guard';
import { RequireAdminGuard } from './require-admin.guard';

export function storageFactory(): OAuthStorage {
  return localStorage;
}

@NgModule({
  imports: [
    CommonModule,
    HttpClientModule,
    OAuthModule.forRoot()
  ],
  providers: [
    AuthService,
    RequireUserGuard,
    RequireAdminGuard
  ]
})
export class AuthModule {
  static forRoot(): ModuleWithProviders<AuthModule> {
    return {
      ngModule: AuthModule,
      providers: [
        {
          provide: AuthConfig,
          useValue: {
            issuer: environment.auth.issuer,
            clientId: environment.auth.clientId,
            responseType: 'code',
            redirectUri: window.location.origin,
            silentRefreshRedirectUri: `${window.location.origin}/silent-refresh.html`,
            useSilentRefresh: true,
            scope: 'openid profile offline_access',
            sessionChecksEnabled: true,
            showDebugInformation: environment.auth.debug,
            clearHashAfterLogin: false,
            nonceStateSeparator: 'semicolon',
          },
        },
        {
          provide: OAuthModuleConfig,
          useValue: {
            resourceServer: {
              allowedUrls: ['/api'],
              sendAccessToken: true,
            },
          },
        },
        {
          provide: OAuthStorage,
          useFactory: storageFactory,
        },
      ],
    };
  }
}
