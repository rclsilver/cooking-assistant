class ServerError {
  loc: Array<string>;
  msg: string;
  type: string;
}

class ServerErrorResponse {
  detail: Array<ServerError>;
}

export {
  ServerError,
  ServerErrorResponse
};
