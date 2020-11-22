import { ModuleWithProviders, NgModule, Optional, SkipSelf } from '@angular/core';
import { HttpClientModule } from '@angular/common/http';
import { AuthConfig, OAuthModule, OAuthModuleConfig, OAuthStorage } from 'angular-oauth2-oidc';
import { AuthService } from './auth.service';
import { environment } from 'src/environments/environment';
import { RequireUserGuard } from './require-user.guard';
import { RequireAdminGuard } from './require-admin.guard';

export function storageFactory(): OAuthStorage {
  return localStorage;
}

@NgModule({
  declarations: [],
  imports: [HttpClientModule, OAuthModule.forRoot()],
  providers: [AuthService, RequireUserGuard, RequireAdminGuard ],
})
export class CoreModule {
  static forRoot(): ModuleWithProviders<CoreModule> {
    return {
      ngModule: CoreModule,
      providers: [
        {
          provide: AuthConfig,
          useValue: {
            issuer: environment.auth.issuer,
            clientId: environment.auth.clientId,
            responseType: 'code',
            redirectUri: window.location.origin + '/index.html',
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

  constructor(@Optional() @SkipSelf() parentModule: CoreModule) {
    if (parentModule) {
      throw new Error(
        'CoreModule is already loaded. Import it in the AppModule only'
      );
    }
  }
}
