from tests.functional import FunctionalTestCase
from werkzeug.exceptions import BadRequest, Forbidden, InternalServerError, MethodNotAllowed, NotFound, Unauthorized


class ErrorsFunctionalTest(FunctionalTestCase):
    def setUp(self):
        super(ErrorsFunctionalTest, self).setUp()

        @self.app.route('/errors/bad-request')
        def bad_request():
            raise BadRequest()

        @self.app.route('/errors/unauthorized')
        def unauthorized():
            raise Unauthorized()

        @self.app.route('/errors/forbidden')
        def forbidden():
            raise Forbidden()

        @self.app.route('/errors/not-found')
        def not_found():
            raise NotFound()

        @self.app.route('/errors/method-not-allowed')
        def method_not_allowed():
            raise MethodNotAllowed()

        @self.app.route('/errors/internal-server-error')
        def internal_server_error():
            raise Exception()

    def test_bad_request(self):
        response = self.call('GET', '/errors/bad-request')
        self.assertErrorIs(response, 400, 'BAD_REQUEST')

    def test_unauthorized(self):
        response = self.call('GET', '/errors/unauthorized')
        self.assertErrorIs(response, 401, 'UNAUTHORIZED')

    def test_forbidden(self):
        response = self.call('GET', '/errors/forbidden')
        self.assertErrorIs(response, 403, 'FORBIDDEN')

    def test_not_found(self):
        response = self.call('GET', '/errors/not-found')
        self.assertErrorIs(response, 404, 'NOT_FOUND')

    def test_method_not_allowed(self):
        response = self.call('GET', '/errors/method-not-allowed')
        self.assertErrorIs(response, 405, 'METHOD_NOT_ALLOWED')

    def test_internal_server_error(self):
        response = self.call('GET', '/errors/internal-server-error')
        self.assertErrorIs(response, 500, 'INTERNAL_SERVER_ERROR')
