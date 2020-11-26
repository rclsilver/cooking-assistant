export type ValidationErrorDetail = {
  loc: string[];
  msg: string;
  type: string;
};

export type ValidationError = {
  detail: ValidationErrorDetail[];
};

export type ControllerErrorContext = {
  resource_type: string;
  resource_id: string;
  fields: string[];
};

export type ControllerError = {
  context: ControllerErrorContext;
  kind: string;
  message: string;
};
