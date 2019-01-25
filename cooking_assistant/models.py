from django.db import models
from uuid import uuid4


class Base(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid4, editable=False)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    @property
    def is_new(self):
        return self._state.adding

    class Meta:
        abstract = True
